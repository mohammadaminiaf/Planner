import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class GetActiveTasksUsecase extends Usecase<List<Task>, NoParams> {
  final TaskRepository taskRepository;
  GetActiveTasksUsecase(this.taskRepository);

  @override
  Future<List<Task>> call(NoParams param) {
    return taskRepository.getActiveTasks();
  }
}
