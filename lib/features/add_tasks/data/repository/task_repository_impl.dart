import 'package:hive/hive.dart';

import '/features/add_tasks/domain/entities/task.dart';
import '/features/add_tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  @override
  Future<void> addTask(Task task) async {
    return await Hive.box<Task>('tasks').put(task.id, task);
  }

  @override
  Future<void> updateTask(Task task) {
    return Hive.box<Task>('tasks').put(task.id, task);
  }

  @override
  Future<void> deleteTask(String id) {
    return Hive.box<Task>('tasks').delete(id);
  }

  @override
  Future<void> toggleTask(Task task) {
    return Hive.box<Task>('tasks').put(task.id, task);
  }
}
