import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class GetAllTasksUsecase extends Usecase<List<Task>, NoParams> {
  GetAllTasksUsecase(this.tasksRepository);
  final TaskRepository tasksRepository;

  @override
  Future<List<Task>> call(NoParams param) {
    return tasksRepository.getAllTasks();
  }
}
