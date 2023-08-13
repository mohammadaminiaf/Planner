import 'package:hive/hive.dart';

import '/features/add_tasks/data/models/task_priority.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;
  @HiveField(1)
  bool isDone;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final TaskPriority priority;
  @HiveField(4)
  final DateTime? deadline;
  @HiveField(5)
  final String id;

  Task({
    required this.title,
    required this.isDone,
    required this.description,
    required this.priority,
    this.deadline,
    required this.id,
  });

  @override
  String toString() => 'Task($title)';
}
