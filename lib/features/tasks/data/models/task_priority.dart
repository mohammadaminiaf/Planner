enum TaskPriority {
  low,
  high,
  medium,
}

enum TasksType {
  all,
  done,
  notDone,
}

extension ToEnum on String {
  TaskPriority toEnum() {
    switch (this) {
      case 'low':
        return TaskPriority.low;
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      default:
        return TaskPriority.medium;
    }
  }
}

extension TaskPriorityExtension on TaskPriority {
  String fromEnumToString() {
    return toString().split('.').last;
  }
}
