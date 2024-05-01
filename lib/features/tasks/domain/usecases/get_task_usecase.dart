import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class GetTaskUsecase extends Usecase<Task, String> {
  final TaskRepository taskRepository;
  GetTaskUsecase(this.taskRepository);

  @override
  Future<Task> call(String param) {
    return taskRepository.getTask(param);
  }
}
