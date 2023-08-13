import 'package:hive/hive.dart';

part 'task_priority.g.dart';

@HiveType(typeId: 2)
enum TaskPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  high,
  @HiveField(2)
  medium,
}

extension ToEnum on String {
  TaskPriority? toEnum() {
    switch (this) {
      case 'low':
        return TaskPriority.low;
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      default:
        return null;
    }
  }
}

extension TaskPriorityExtension on TaskPriority {
  String fromEnumToString() {
    return toString().split('.').last;
  }
}
