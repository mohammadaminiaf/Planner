import 'package:hive/hive.dart';

import '/features/add_tasks/domain/entities/task.dart';
import '/features/view_tasks/domain/repository/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  @override
  List<Task> getAllTasks() {
    final tasks = Hive.box<Task>('tasks');
    final listOfTasks = tasks.values.toList();
    final orderedTasks = listOfTasks
      ..sort(
        (Task a, Task b) => a.deadline!.compareTo(
          b.deadline!,
        ),
      );
    return orderedTasks;
  }
}
