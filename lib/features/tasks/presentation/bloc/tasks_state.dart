part of 'tasks_bloc.dart';

@immutable
sealed class TasksState extends Equatable {
  final List<Task>? tasks;
  final String? error;
  final bool isLoading;

  const TasksState({
    this.tasks,
    this.error,
    this.isLoading = false,
  });
}

final class TasksInitial extends TasksState {
  const TasksInitial() : super(tasks: const []);

  @override
  List<Object?> get props => [];
}

final class TasksLoaded extends TasksState {
  const TasksLoaded({required List<Task> tasks})
      : super(
          tasks: tasks,
          isLoading: false,
          error: null,
        );

  int get tasksCount => tasks!.length;
  int get completedTasksCount =>
      tasks!.where((task) => task.isCompleted == true).length;

  @override
  List<Object?> get props => [tasks, isLoading, error];
}

final class TasksLoading extends TasksState {
  const TasksLoading() : super(isLoading: true);

  @override
  List<Object?> get props => [isLoading];
}

final class TasksError extends TasksState {
  const TasksError({required String error}) : super(error: error);

  @override
  List<Object?> get props => [error];
}
