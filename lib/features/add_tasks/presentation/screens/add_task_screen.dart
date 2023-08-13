import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '/core/constants/constants.dart';
import '/core/providers/tasks_provider.dart';
import '/core/utils/utils.dart';
import '/core/widgets/delete_dialog.dart';
import '/features/add_tasks/data/models/task_priority.dart';
import '/features/add_tasks/domain/entities/task.dart';
import '/features/add_tasks/presentation/widgets/add_update_task_button.dart';
import '/features/add_tasks/presentation/widgets/description_text_field.dart';
import '/features/add_tasks/presentation/widgets/priority_dropdown_button.dart';
import '/features/add_tasks/presentation/widgets/title_text_field.dart';

final _formKey = GlobalKey<FormState>();

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({
    Key? key,
    this.task,
    this.index,
  }) : super(key: key);

  final Task? task;
  final int? index;

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  /// locale variables
  bool _isButtonActive = true;

  /// Text Field variables
  DateTime? taskDeadline = DateTime.now();
  bool isDone = false;
  TaskPriority priority = TaskPriority.medium;
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
      taskDeadline = widget.task!.deadline;
      priority = widget.task!.priority;
      isDone = widget.task!.isDone;
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
              isDone: isDone,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //! Title text form field
                      TitleTextField(
                        controller: titleController,
                      ),
                      //! Description text form field
                      DescriptionTextField(
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 20),
                      //! Priority Dropdown button
                      PriorityDropdownButton(
                        onChanged: (value) {
                          priority = value as TaskPriority;
                        },
                        priority: priority,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AddUpdateTaskButton(
                  isAdding: widget.task == null,
                  onPressed: _isButtonActive
                      ? () => _submit(
                            isDone: isDone,
                            context: context,
                          )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit({
    required bool isDone,
    required BuildContext context,
  }) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final taskId = const Uuid().v1();
      final task = Task(
        id: widget.task == null ? taskId : widget.task!.id,
        priority: priority,
        title: titleController.text,
        description: descriptionController.text,
        isDone: isDone,
        deadline: taskDeadline,
      );
      bool isAdding = widget.task == null;
      if (isAdding) {
        ref.read(tasksProvider.notifier).addTask(task);
      } else {
        ref.read(tasksProvider.notifier).updateTask(task, widget.index!);
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
              id: widget.task!.id,
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
      icon: const Icon(Icons.save),
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
      icon: const Icon(Icons.delete),
    );
  }
}
