part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent extends Equatable {
  const TasksEvent();
}

//! Add Task Event
final class AddTaskEvent extends TasksEvent {
  final Task task;

  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

//! Update Task Event
final class UpdateTaskEvent extends TasksEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

//! Delete Task Event
final class DeleteTaskEvent extends TasksEvent {
  final int id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

//! Mark task as Completed Event
final class MarkTaskAsCompletedEvent extends TasksEvent {
  final int id;
  final bool isCompleted;

  const MarkTaskAsCompletedEvent({
    required this.id,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, isCompleted];
}

//! Get A single task event
final class GetTaskEvent extends TasksEvent {
  final String id;

  const GetTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

//! Get All Tasks Event
final class GetAllTasksEvent extends TasksEvent {
  const GetAllTasksEvent();

  @override
  List<Object?> get props => [];
}

//! Get Active Tasks Event
final class GetActiveTasksEvent extends TasksEvent {
  const GetActiveTasksEvent();

  @override
  List<Object?> get props => [];
}

//! Get Completed Tasks Event
final class GetCompletedTasksEvent extends TasksEvent {
  const GetCompletedTasksEvent();

  @override
  List<Object?> get props => [];
}

//! Sort Tasks
final class SortTasks extends TasksEvent {
  final bool isDescending;

  const SortTasks({required this.isDescending});

  @override
  List<Object?> get props => [isDescending];
}
