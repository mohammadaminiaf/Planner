import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loading_screen.dart';
import '/features/tasks/constants/constants.dart';
import '/features/tasks/data/data_source/local/tasks_database.dart';
import '/features/tasks/data/models/task_priority.dart';
import '/features/tasks/presentation/bloc/tasks_bloc.dart';
import '/features/tasks/presentation/views/tasks_list.dart';
import '/features/tasks/presentation/widgets/add_task_fab.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    Key? key,
    this.payload,
  }) : super(key: key);

  final String? payload;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    isDescending = prefs.getBool(Constants.isDesending) ?? true;
  }

  DateTime? lastPressed;
  bool isFabVisible = true;
  bool isDescending = true;

  Future<bool?> shouldPopScreen(bool willPop) async {
    DateTime now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    bool isWarning =
        lastPressed == null || now.difference(lastPressed!) > maxDuration;

    if (isWarning) {
      lastPressed = DateTime.now();
      final snackBar = SnackBar(
        content: Text(
          AppLocalizations.of(context)!.closeSnackBarMessage,
        ),
        duration: maxDuration,
      );

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);

      return false;
    } else {
      // if (boxLength < 5) {
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const ExitDialog();
      //     },
      //   );
      // }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: shouldPopScreen,
      child: Scaffold(
        floatingActionButton: isFabVisible ? const AddTaskFab() : null,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!isFabVisible) setState(() => isFabVisible = true);
            } else if (notification.direction == ScrollDirection.reverse) {
              if (isFabVisible) setState(() => isFabVisible = false);
            }
            return true;
          },
          child: FutureBuilder(
            future: TasksDatabase.instance.database,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              }

              if (snapshot.data != null) {
                context.read<TasksBloc>().add(const GetAllTasksEvent());
                return BlocBuilder<TasksBloc, TasksState>(
                  builder: (context, state) {
                    if (state.tasks != null && state is TasksLoaded) {
                      return CustomScrollView(
                        slivers: [
                          // AppBar
                          SliverAppBar(
                            expandedHeight: 100,
                            collapsedHeight: kToolbarHeight,
                            title: Text(AppLocalizations.of(context)!.appMotto),
                            flexibleSpace: AppBarFlexibleSpace(
                              tasksLength: state.tasksCount,
                              doneTasks: state.completedTasksCount,
                            ),
                            actions: [
                              SortTaskIconButton(
                                isDescending: isDescending,
                                onChanged: (value) {
                                  isDescending = value;
                                },
                              ),
                              const FilterPopupMenuButton(),
                            ],
                          ),

                          // List of Tasks
                          TasksList(
                            tasks: state.tasks!,
                          ),
                        ],
                      );
                    }

                    return const LoadingScreen();
                  },
                );
              }

              return ErrorScreen(
                error: snapshot.error.toString(),
              );
            },
          ),
        ),
      ),
    );
  }
}

//! Sort Tasks Icon Button
class SortTaskIconButton extends StatelessWidget {
  const SortTaskIconButton({
    super.key,
    required this.isDescending,
    required this.onChanged,
  });

  final bool isDescending;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        context.read<TasksBloc>().add(
              SortTasks(isDescending: isDescending),
            );
        onChanged(!isDescending);
      },
      icon: const Icon(Icons.sort),
    );
  }
}

//! Filter Popup Button
class FilterPopupMenuButton extends StatefulWidget {
  const FilterPopupMenuButton({super.key});

  @override
  State<FilterPopupMenuButton> createState() => _FilterPopupMenuButtonState();
}

class _FilterPopupMenuButtonState extends State<FilterPopupMenuButton> {
  TasksType tasksType = TasksType.all;

  @override
  Widget build(BuildContext context) {
    final filterOptions = [
      FilterTaskItem(AppLocalizations.of(context)!.all, TasksType.all),
      FilterTaskItem(AppLocalizations.of(context)!.done, TasksType.done),
      FilterTaskItem(AppLocalizations.of(context)!.notDone, TasksType.notDone),
    ];

    return PopupMenuButton(
      onSelected: (TasksType value) {
        tasksType = value;
        switch (value) {
          case TasksType.all:
            context.read<TasksBloc>().add(const GetAllTasksEvent());
            break;

          case TasksType.notDone:
            context.read<TasksBloc>().add(const GetActiveTasksEvent());
            break;

          case TasksType.done:
            context.read<TasksBloc>().add(const GetCompletedTasksEvent());
            break;
        }
      },
      itemBuilder: (context) {
        return filterOptions
            .map(
              (filterOption) => PopupMenuItem(
                value: filterOption.value,
                child: Text(
                  filterOption.title,
                ),
              ),
            )
            .toList();
      },
    );
  }
}

//! Filter Task Item
class FilterTaskItem {
  final String title;
  final TasksType value;

  const FilterTaskItem(this.title, this.value);
}

class AppBarFlexibleSpace extends StatelessWidget {
  const AppBarFlexibleSpace({
    super.key,
    required this.tasksLength,
    required this.doneTasks,
  });

  final int tasksLength;
  final int doneTasks;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight + 35,
          left: 18,
          right: 18,
          bottom: 10,
        ),
        child: Text(
          '${AppLocalizations.of(context)!.done}\t $doneTasks / $tasksLength',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
