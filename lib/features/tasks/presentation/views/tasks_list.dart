import 'package:flutter/material.dart';

import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/presentation/widgets/task_list_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskListTile(
          task: task,
          index: index,
        );
      },
    );
  }
}
