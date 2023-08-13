import '/core/usecase/usecases.dart';
import '/features/add_tasks/domain/repository/task_repository.dart';

class DeleteTaskUsecase extends Usecase<void, String> {
  DeleteTaskUsecase(this.taskRepository);
  TaskRepository taskRepository;

  @override
  Future call(param) {
    return taskRepository.deleteTask(param);
  }
}
