import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class UpdateTaskUsecase implements Usecase<void, Task> {
  UpdateTaskUsecase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<void> call(Task param) {
    return taskRepository.updateTask(param);
  }
}
