import '/core/usecase/usecases.dart';
import '/features/add_tasks/domain/repository/task_repository.dart';
import '/features/add_tasks/domain/entities/task.dart';

class AddTaskUsecase implements Usecase<void, Task> {
  AddTaskUsecase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<void> call(Task param) {
    return taskRepository.addTask(param);
  }
}
