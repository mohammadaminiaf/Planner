import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/theme/app_colors.dart';
import '/features/tasks/data/models/task_priority.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/presentation/bloc/tasks_bloc.dart';
import '/features/tasks/presentation/screens/add_task_screen.dart';
import '/features/tasks/presentation/widgets/circular_check_box.dart';
import '/features/tasks/presentation/widgets/task_subtitle_widget.dart';
import '/features/tasks/presentation/widgets/task_title_widget.dart';

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
      leading: CircularCheckBox(
        priorityColor: getPriorityColor(task.priority),
        isChecked: task.isCompleted,
        onChanged: (value) {
          task.copyWith(isCompleted: value);
          context.read<TasksBloc>().add(
                MarkTaskAsCompletedEvent(
                  id: task.id!,
                  isCompleted: value ?? false,
                ),
              );
        },
      ),

      //! Title part of the List Tile
      title: TaskTitleWidget(
        isDone: task.isCompleted,
        title: task.title,
      ),
      //! Subtitle part of the List Tile
      subtitle: TaskSubtitleWidget(
        description: task.description,
        startDate: task.startDate,
        endDate: task.endDate,
        isChecked: task.isCompleted,
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
