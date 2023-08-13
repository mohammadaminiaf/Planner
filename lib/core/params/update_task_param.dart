import '/features/add_tasks/domain/entities/task.dart';

class UpdateTaskParam {
  final Task task;
  final int index;

  UpdateTaskParam({
    required this.task,
    required this.index,
  });
}
