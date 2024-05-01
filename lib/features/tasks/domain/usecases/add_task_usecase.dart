import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class AddTaskUsecase implements Usecase<void, Task> {
  AddTaskUsecase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<void> call(Task param) {
    return taskRepository.addTask(param);
  }
}
