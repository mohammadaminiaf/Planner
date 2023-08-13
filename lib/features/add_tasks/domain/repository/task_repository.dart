import '/features/add_tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> toggleTask(Task task);
}
