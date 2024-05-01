import '/features/tasks/domain/entities/task.dart';

class ToggleTaskParam {
  final Task task;
  final bool isChecked;

  const ToggleTaskParam({
    required this.task,
    required this.isChecked,
  });
}
