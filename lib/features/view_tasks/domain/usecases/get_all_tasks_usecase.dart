import '/features/add_tasks/domain/entities/task.dart';
import '/features/view_tasks/domain/repository/tasks_repository.dart';

class GetAllTasksUsecase {
  GetAllTasksUsecase(this.tasksRepository);
  TasksRepository tasksRepository;

  List<Task> getAllTasks() {
    return tasksRepository.getAllTasks();
  }
}
