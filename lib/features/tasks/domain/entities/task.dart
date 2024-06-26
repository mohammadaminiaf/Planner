import '/features/tasks/data/models/task_priority.dart';

// Table name
const String tasksTable = 'tasks';

class TaskFields {
  static final List<String> values = [
    id,
    title,
    description,
    dateCreated,
    dateUpdated,
    priority,
    isCompleted,
    startDate,
    notifyAt,
    notificationSchedule,
  ];

  // Define column names for tasks table
  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String dateCreated = 'dateCreated';
  static const String dateUpdated = 'dateUpdated';
  static const String isCompleted = 'isCompleted';
  static const String priority = 'priority';
  static const String startDate = 'startDate';
  static const String notifyAt = 'notifyAt';
  static const String notificationSchedule = 'notificationSchedule';
}

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final bool isCompleted;
  final TaskPriority priority;
  final DateTime startDate;
  final DateTime? notifyAt;
  final String? notificationSchedule;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.dateUpdated,
    required this.isCompleted,
    required this.priority,
    required this.startDate,
    this.notifyAt,
    this.notificationSchedule,
  });

  @override
  String toString() => 'Task() => $title: $isCompleted';

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateCreated,
    DateTime? dateUpdated,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? notifyAt,
    String? notificationSchedule,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dateCreated: dateCreated ?? this.dateCreated,
        dateUpdated: dateUpdated ?? this.dateUpdated,
        isCompleted: isCompleted ?? this.isCompleted,
        priority: priority ?? this.priority,
        startDate: startDate ?? this.startDate,
        notifyAt: notifyAt ?? this.notifyAt,
        notificationSchedule: notificationSchedule ?? this.notificationSchedule,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TaskFields.id: id,
      TaskFields.title: title,
      TaskFields.description: description,
      TaskFields.dateCreated: dateCreated.toIso8601String(),
      TaskFields.dateUpdated: dateUpdated.toIso8601String(),
      TaskFields.isCompleted: isCompleted ? 1 : 0,
      TaskFields.priority: priority.fromEnumToString(),
      TaskFields.startDate: startDate.toIso8601String(),
      TaskFields.notifyAt: notifyAt?.toIso8601String(),
      TaskFields.notificationSchedule: notificationSchedule,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[TaskFields.id] as int,
      title: map[TaskFields.title] as String,
      description: map[TaskFields.description] as String,
      dateCreated: DateTime.parse(map[TaskFields.dateCreated] as String),
      dateUpdated: DateTime.parse(map[TaskFields.dateUpdated] as String),
      isCompleted: map[TaskFields.isCompleted] == 1,
      priority: (map[TaskFields.priority] as String).toEnum(),
      startDate: DateTime.parse(map[TaskFields.startDate] as String),
      notifyAt: map[TaskFields.notifyAt] != null
          ? DateTime.parse(map[TaskFields.notifyAt] as String)
          : null,
      notificationSchedule: map[TaskFields.notificationSchedule],
    );
  }
}
