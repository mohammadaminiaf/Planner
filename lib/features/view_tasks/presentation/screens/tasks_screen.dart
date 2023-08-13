import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/providers/tasks_provider.dart';
import '/core/widgets/exit_dialog.dart';
import '../../../../core/widgets/main_drawer.dart';
import '/features/add_tasks/presentation/widgets/add_task_fab.dart';
import '/features/view_tasks/data/models/tasks_type.dart';
import '/features/view_tasks/presentation/widgets/tasks_list.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({
    Key? key,
    this.payload,
  }) : super(key: key);

  final String? payload;

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime? lastPressed;
  bool isFabVisible = true;
  TasksType tasksType = TasksType.all;

  Future<bool> shouldPopScreen() async {
    var boxLength = ref.read(tasksProvider.notifier).tasksLength;
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
      if (boxLength < 5) {
        showDialog(
          context: context,
          builder: (context) {
            return const ExitDialog();
          },
        );
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterOptions = [
      FilterTaskItem(AppLocalizations.of(context)!.all, TasksType.all),
      FilterTaskItem(AppLocalizations.of(context)!.done, TasksType.done),
      FilterTaskItem(AppLocalizations.of(context)!.notDone, TasksType.notDone),
    ];

    return WillPopScope(
      onWillPop: shouldPopScreen,
      child: Consumer(
        builder: (_, ref, ch) {
          final tasks = ref.watch(tasksProvider);
          final doneTasks = tasks.where((task) => task.isDone == true).length;
          final tasksLength = tasks.length;
          return Scaffold(
            // backgroundColor: Colors.white,
            drawer: const MainDrawer(),
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
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 100,
                    collapsedHeight: kToolbarHeight,
                    title: Text(AppLocalizations.of(context)!.appMotto),
                    flexibleSpace: AppBarFlexibleSpace(
                      tasksLength: tasksLength,
                      doneTasks: doneTasks,
                    ),
                    actions: [
                      PopupMenuButton(
                        onSelected: (TasksType value) {
                          tasksType = value;
                          ref.read(tasksProvider.notifier).tasksType = value;
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
                      ),
                    ],
                  ),
                  TasksList(
                    tasks: tasks,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
