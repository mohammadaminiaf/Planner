import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/app/theme/app_colors.dart';
import '/core/providers/tasks_provider.dart';
import '/features/add_tasks/data/models/task_priority.dart';
import '/features/add_tasks/domain/entities/task.dart';
import '/features/add_tasks/presentation/screens/add_task_screen.dart';
import '/features/view_tasks/presentation/widgets/circular_check_box.dart';
import 'task_subtitle_widget.dart';
import 'task_title_widget.dart';

class TaskListTile extends StatelessWidget {
  final int index;
  final Task task;

  const TaskListTile({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //! Leading part of List Tile
      leading: Consumer(
        builder: (context, ref, child) {
          return CircularCheckBox(
            isChecked: task.isDone,
            onChanged: (value) {
              task.isDone = value!;
              ref.read(tasksProvider.notifier).toggleTask(
                    task: Task(
                      id: task.id,
                      priority: task.priority,
                      title: task.title,
                      isDone: value,
                      description: task.description,
                      deadline: task.deadline,
                    ),
                  );
            },
          );
        },
      ),
      //! Title part of the List Tile
      title: TaskTitleWidget(
        isDone: task.isDone,
        title: task.title,
      ),
      //! Subtitle part of the List Tile
      subtitle: task.description.isEmpty
          ? null
          : TaskSubtitleWidget(
              subtitle: task.description,
              isChecked: task.isDone,
            ),
      //! Tailing part of the List Tile
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                task: task,
                index: index,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.more_horiz,
          size: 35,
          color: AppColors.blurredGrey,
        ),
      ),
    );
  }

  Color setColor(TaskPriority priority) {
    if (priority == TaskPriority.high) {
      return Colors.red;
    } else if (priority == TaskPriority.medium) {
      return Colors.lightBlue;
    } else {
      return Colors.grey;
    }
  }
}
