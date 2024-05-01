import '/core/usecase/usecases.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class DeleteTaskUsecase extends Usecase<void, int> {
  DeleteTaskUsecase(this.taskRepository);
  TaskRepository taskRepository;

  @override
  Future call(param) {
    return taskRepository.deleteTask(param);
  }
}
