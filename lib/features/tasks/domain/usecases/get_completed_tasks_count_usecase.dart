import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class GetCompletedTasksUsecase extends Usecase<List<Task>, NoParams> {
  final TaskRepository taskRepository;
  GetCompletedTasksUsecase(this.taskRepository);

  @override
  Future<List<Task>> call(NoParams param) {
    return taskRepository.getCompletedTasks();
  }
}
