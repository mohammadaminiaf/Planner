import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
  Future<void> markTaskAsCompleted(MarkTaskAsCompletedParams param);
  Future<Task> getTask(String id);
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getActiveTasks();
  Future<List<Task>> getCompletedTasks();
  Future<void> sortTasks(bool isDescending);
}
