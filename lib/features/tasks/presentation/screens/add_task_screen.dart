import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/constants.dart';
import '/core/utils/utils.dart';
import '/core/widgets/delete_dialog.dart';
import '/features/tasks/data/models/task_priority.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/presentation/bloc/tasks_bloc.dart';
import '/features/tasks/presentation/views/add_task_form.dart';
import '/features/tasks/presentation/widgets/add_update_task_button.dart';

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
  DateTime _endDate = DateTime.now();
  DateTime _dateCreated = DateTime.now();
  DateTime _dateUpdated = DateTime.now();
  DateTime? _notifyAt = DateTime.now();
  bool _isCompleted = false;
  TaskPriority _priority = TaskPriority.medium;

  //& Text Editing controllers
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    titleController.addListener(
      () {
        final isButtonActive = titleController.text.isNotEmpty;
        setState(() => _isButtonActive = isButtonActive);
      },
    );

    if (widget.task != null) {
      descriptionController.text = widget.task!.description;
      titleController.text = widget.task!.title;
      _startDate = widget.task!.startDate;
      _endDate = widget.task!.endDate;
      _dateCreated = widget.task!.dateCreated;
      _dateUpdated = widget.task!.dateUpdated;
      _notifyAt = widget.task!.notifyAt;
      _priority = widget.task!.priority;
      _isCompleted = widget.task!.isCompleted;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
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
            onPressed: () => _submit(
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
                    titleController: titleController,
                    descriptionController: descriptionController,
                    priority: _priority,
                    startDate: _startDate,
                    endDate: _endDate,
                    notifyAt: _notifyAt,
                    //! Pass value changed methods
                    onPrioirtyChanged: (priority) => setState(() {
                      _priority = priority;
                    }),
                    onStartDateChanged: (startDate) => setState(() {
                      _startDate = startDate ?? DateTime.now();
                    }),
                    onEndDateChanged: (endDate) => setState(() {
                      _endDate = endDate ?? DateTime.now();
                    }),
                    onNotifyAtChanged: (notifyAt) {
                      _notifyAt = notifyAt;
                    },
                  ),
                  const SizedBox(height: 20),
                  AddUpdateTaskButton(
                    isAdding: widget.task == null,
                    onPressed: _isButtonActive
                        ? () => _submit(
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

  void _submit({
    required bool isCompleted,
    required BuildContext context,
  }) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // final taskId = const Uuid().v1();
      bool isAdding = widget.task == null;

      if (isAdding) {
        addTask();
      } else {
        updateTask();
      }
      Navigator.of(context).pop();
    }
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
      title: titleController.text,
      description: descriptionController.text,
      isCompleted: _isCompleted,
      dateCreated: _dateCreated,
      dateUpdated: _dateUpdated,
      endDate: _endDate,
      startDate: _startDate,
    );

    context.read<TasksBloc>().add(AddTaskEvent(task: task));
  }

  Future updateTask() async {
    final task = widget.task!.copyWith(
      title: titleController.text,
      description: descriptionController.text,
      priority: _priority,
      dateCreated: _dateCreated,
      dateUpdated: _dateUpdated,
      startDate: _startDate,
      endDate: _endDate,
    );
    context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
  }
}

class SaveTaskButton extends StatelessWidget {
  const SaveTaskButton({
    Key? key,
    required this.isButtonActive,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isButtonActive;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isButtonActive ? onPressed : null,
      icon: Icon(
        Icons.save,
        color: isButtonActive ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({
    Key? key,
    required this.onPressed,
    required this.isButtonActive,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isButtonActive;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isButtonActive ? onPressed : null,
      icon: Icon(
        Icons.delete,
        color: isButtonActive ? Colors.red : null,
      ),
    );
  }
}
