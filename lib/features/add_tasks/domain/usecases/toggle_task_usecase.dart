import '/core/usecase/usecases.dart';
import '/features/add_tasks/domain/entities/task.dart';
import '/features/add_tasks/domain/repository/task_repository.dart';

class ToggleTaskUsecase implements Usecase<void, Task> {
  ToggleTaskUsecase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<void> call(Task param) {
    return taskRepository.toggleTask(param);
  }
}
