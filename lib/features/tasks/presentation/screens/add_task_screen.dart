import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/constants.dart';
import '/core/utils/utils.dart';
import '/core/widgets/delete_dialog.dart';
import '/features/notifications/domain/entities/notification_params.dart';
import '/features/notifications/presentation/bloc/notification_bloc.dart';
import '/features/tasks/data/models/task_priority.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/presentation/bloc/tasks_bloc.dart';
import '/features/tasks/presentation/views/add_task_form.dart';
import '/features/tasks/presentation/widgets/add_update_task_button.dart';
import '/features/tasks/presentation/widgets/delete_task_button.dart';
import '/features/tasks/presentation/widgets/save_task_button.dart';

final _formKey = GlobalKey<FormState>();

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    Key? key,
    this.task,
    this.index,
  }) : super(key: key);

  final Task? task;
  final int? index;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  /// locale variables
  bool _isButtonActive = true;

  /// Text Field variables
  DateTime _startDate = DateTime.now();
  DateTime _dateCreated = DateTime.now();
  DateTime _dateUpdated = DateTime.now();
  bool _isCompleted = false;
  TaskPriority _priority = TaskPriority.medium;

  //? Notification related variables
  DateTime? _notifyAt;
  String? _notificationSchedule;

  //& Text Editing controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleController.addListener(
      () {
        final isButtonActive = _titleController.text.isNotEmpty;
        setState(() => _isButtonActive = isButtonActive);
      },
    );

    //! If we are updating a task
    if (widget.task != null) {
      _descriptionController.text = widget.task!.description;
      _titleController.text = widget.task!.title;
      _startDate = widget.task!.startDate;
      _dateCreated = widget.task!.dateCreated;
      _dateUpdated = widget.task!.dateUpdated;
      _notifyAt = widget.task?.notifyAt;
      _notificationSchedule = widget.task?.notificationSchedule;
      _priority = widget.task!.priority;
      _isCompleted = widget.task!.isCompleted;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addTask,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          DeleteTaskButton(
            onPressed: _deleteTask,
            isButtonActive: widget.task != null,
          ),
          SaveTaskButton(
            isButtonActive: _isButtonActive,
            onPressed: () => _addUpdateTask(
              isCompleted: _isCompleted,
              context: context,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: modalDialogBoxDecoration,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AddTaskForm(
                    //! Pass normal fields
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    priority: _priority,
                    startDate: _startDate,
                    //! Pass value changed methods
                    onPrioirtyChanged: (priority) => setState(() {
                      _priority = priority;
                    }),
                    onStartDateChanged: (startDate) => setState(() {
                      _startDate = startDate ?? DateTime.now();
                    }),
                    onNotifyAtChanged: (notifyAt) => setState(
                      () {
                        _notifyAt = notifyAt;
                        debugPrint(
                          'Notfiy at: ${notifyAt!.hour}:${notifyAt.minute}',
                        );
                      },
                    ),
                    onNotificationScheduleChanged: (notificationSchedule) {
                      _notificationSchedule = notificationSchedule;
                    },
                    //! This enables you to control notification date select widget
                    resetIf: () {
                      if (_notifyAt!.isBefore(DateTime.now())) {
                        showToastMessage(
                            text: 'The Date you selected is in the past.');
                        return true;
                      }
                      return false;
                    },
                    notificationSchedule: _notificationSchedule,
                    notifyAt: _notifyAt,
                  ),
                  const SizedBox(height: 20),
                  AddUpdateTaskButton(
                    isAdding: widget.task == null,
                    onPressed: _isButtonActive
                        ? () => _addUpdateTask(
                              isCompleted: _isCompleted,
                              context: context,
                            )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addUpdateTask({
    required bool isCompleted,
    required BuildContext context,
  }) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool isAdding = widget.task == null;

      if (isAdding) {
        addTask();
      } else {
        updateTask();
      }

      /// Show notification only if the user has selected a time and it's not in the past
      /// And if the time's in the past, do not set a 2nd time.
      if (_notifyAt != null && _notifyAt!.isAfter(DateTime.now())) {
        showNotification();
      }

      Navigator.of(context).pop();
    }
  }

  void showNotification() {
    context.read<NotificationBloc>().add(
          SendNotificationEvent(
            NotificationParams(
              title: _titleController.text,
              body: _descriptionController.text,
              bigPictureUrl: 'assets/images/splash.jfif',
              largeIconUrl: 'assets/icons/icon.png',
              startAt: _notifyAt!,
            ),
          ),
        );
  }

  Future _deleteTask() async {
    try {
      if (widget.task != null && widget.index != null) {
        await showDialog(
          context: context,
          builder: (context) {
            return DeleteDialog(
              id: widget.task!.id!,
              index: widget.index!,
            );
          },
        ).then((value) {
          if (value == true) {
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      showSnackBar(
        context: context,
        text: e.toString(),
      );
    }
  }

  Future addTask() async {
    final task = Task(
      priority: _priority,
      title: _titleController.text,
      description: _descriptionController.text,
      isCompleted: _isCompleted,
      dateCreated: _dateCreated,
      dateUpdated: _dateUpdated,
      startDate: _startDate,
      notifyAt: _notifyAt,
      notificationSchedule: _notificationSchedule,
    );

    context.read<TasksBloc>().add(AddTaskEvent(task: task));
  }

  Future updateTask() async {
    final task = widget.task!.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      priority: _priority,
      dateCreated: _dateCreated,
      dateUpdated: _dateUpdated,
      startDate: _startDate,
      notifyAt: _notifyAt,
      notificationSchedule: _notificationSchedule,
    );
    context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
  }
}
