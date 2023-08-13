import '/features/add_tasks/domain/entities/task.dart';

abstract class TasksRepository {
  List<Task> getAllTasks();
}
