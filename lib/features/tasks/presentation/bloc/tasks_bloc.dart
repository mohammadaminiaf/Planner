import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/features/tasks/domain/usecases/get_sorted_tasks_usecase.dart';

import '/core/usecase/usecases.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/usecases/add_task_usecase.dart';
import '/features/tasks/domain/usecases/delete_task_usecase.dart';
import '/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import '/features/tasks/domain/usecases/get_completed_tasks_count_usecase.dart';
import '/features/tasks/domain/usecases/get_task_usecase.dart';
import '/features/tasks/domain/usecases/get_tasks_count_usecase.dart';
import '/features/tasks/domain/usecases/toggle_task_usecase.dart';
import '/features/tasks/domain/usecases/update_task_usecase.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUsecase getAllTasksUsecase;
  final AddTaskUsecase addTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final GetTaskUsecase getTaskUsecase;
  final MarkTaskAsCompletedUsecase markTaskAsCompletedUsecase;
  final GetActiveTasksUsecase getActiveTasksUsecase;
  final GetCompletedTasksUsecase getCompletedTasksUsecase;
  final SortTasksUsecase sortTaskUsecase;

  TasksBloc({
    required this.getAllTasksUsecase,
    required this.addTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
    required this.getTaskUsecase,
    required this.markTaskAsCompletedUsecase,
    required this.getActiveTasksUsecase,
    required this.getCompletedTasksUsecase,
    required this.sortTaskUsecase,
  }) : super(const TasksInitial()) {
    //! Handle Adding a Task Event
    on<AddTaskEvent>((event, emit) async {
      try {
        // start loading
        emit(const TasksLoading());

        // Add task to db and bloc
        await addTaskUsecase(event.task);

        // get existing tasks from db
        final tasks = await getAllTasksUsecase(NoParams());

        // emit tasks loaded state with new tasks included
        emit(TasksLoaded(tasks: tasks));
      } catch (e) {
        emit(const TasksError(error: 'Failed to Add a task'));
      }
    });

    //! Handle Updating a Task Event
    on<UpdateTaskEvent>((event, emit) async {
      // Update tasks in database
      await updateTaskUsecase(event.task);

      // get existing tasks from db
      final tasks = await getAllTasksUsecase(NoParams());

      // emit a loaded state
      emit(TasksLoaded(tasks: tasks));
    });

    //! Handle Deleting a task event
    on<DeleteTaskEvent>((event, emit) async {
      // Delete a task from database
      await deleteTaskUsecase(event.id);

      // get existing tasks from db
      final tasks = await getAllTasksUsecase(NoParams());

      // emit a loaded state
      emit(TasksLoaded(tasks: tasks));
    });

    //! Handle Marking a task as Completed
    on<MarkTaskAsCompletedEvent>((event, emit) async {
      // Mark task as completed in DB
      await markTaskAsCompletedUsecase(
        MarkTaskAsCompletedParams(
          event.id,
          event.isCompleted,
        ),
      );

      // get existing tasks from db
      final tasks = await getAllTasksUsecase(NoParams());

      // emit a loaded state
      emit(TasksLoaded(tasks: tasks));
    });

    //! Handle Get All Tasks Event
    on<GetAllTasksEvent>((event, emit) async {
      try {
        emit(const TasksLoading());

        final tasks = await getAllTasksUsecase(NoParams());

        emit(TasksLoaded(tasks: tasks));
      } catch (e) {
        emit(const TasksError(error: 'Failed to retrieve tasks'));
      }
    });

    //! Handle getting Active Tasks
    on<GetActiveTasksEvent>((event, emit) async {
      try {
        emit(const TasksLoading());

        final tasks = await getActiveTasksUsecase(NoParams());

        emit(TasksLoaded(tasks: tasks));
      } catch (e) {
        emit(const TasksError(error: 'Failed to retrieve tasks'));
      }
    });

    //! Handle getting Completed Tasks
    on<GetCompletedTasksEvent>((event, emit) async {
      try {
        emit(const TasksLoading());

        final tasks = await getCompletedTasksUsecase(NoParams());

        emit(TasksLoaded(tasks: tasks));
      } catch (e) {
        emit(const TasksError(error: 'Failed to retrieve tasks'));
      }
    });

    //! Handle sorting Tasks
    on<SortTasks>((event, emit) async {
      try {
        await sortTaskUsecase(event.isDescending);
        final tasks = await getAllTasksUsecase(NoParams());

        print(tasks);

        emit(TasksLoaded(tasks: tasks));
      } catch (e) {
        emit(const TasksError(error: 'Failed to retrieve tasks'));
      }
    });
  }
}
