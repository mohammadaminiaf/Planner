import '/core/usecase/usecases.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class SortTasksUsecase implements Usecase<void, bool> {
  SortTasksUsecase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<void> call(bool param) {
    return taskRepository.sortTasks(param);
  }
}
