import '/core/usecase/usecases.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class MarkTaskAsCompletedUsecase
    implements Usecase<void, MarkTaskAsCompletedParams> {
  MarkTaskAsCompletedUsecase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<void> call(MarkTaskAsCompletedParams param) {
    return taskRepository.markTaskAsCompleted(
      MarkTaskAsCompletedParams(
        param.id,
        param.isCompleted,
      ),
    );
  }
}
