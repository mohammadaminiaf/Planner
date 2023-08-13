import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner/core/utils/utils.dart';

import '/features/add_tasks/domain/entities/task.dart';
import '/features/add_tasks/domain/usecases/add_task_usecase.dart';
import '/features/add_tasks/domain/usecases/delete_task_usecase.dart';
import '/features/add_tasks/domain/usecases/toggle_task_usecase.dart';
import '/features/add_tasks/domain/usecases/update_task_usecase.dart';
import '/features/view_tasks/data/models/tasks_type.dart';
import '/features/view_tasks/domain/usecases/get_all_tasks_usecase.dart';
import '/locator.dart';

class TasksProvider extends StateNotifier<List<Task>> {
  final AddTaskUsecase addTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final ToggleTaskUsecase toggleTaskUsecase;
  final GetAllTasksUsecase getAllTasksUsecase;

  TasksProvider({
    required this.addTaskUsecase,
    required this.deleteTaskUsecase,
    required this.updateTaskUsecase,
    required this.toggleTaskUsecase,
    required this.getAllTasksUsecase,
  }) : super([]) {
    getFilteredTasks(tasksType);
    addListener(_updateCounts);
  }

  int _doneTasks = 0;
  int _tasksLength = 0;
  TasksType _tasksType = TasksType.all;

  int get doneTasks => _doneTasks;
  int get tasksLength => _tasksLength;
  TasksType get tasksType => _tasksType;

  void _updateCounts(List<Task> task) {
    _doneTasks = state.where((Task task) => task.isDone == true).length;
    _tasksLength = state.length;
  }

  /// every time you set tasksType it gets filtered tasks and put them inside task list
  set tasksType(TasksType type) {
    _tasksType = type;
    getFilteredTasks(type);
  }

  /// Add a new task to the DB
  Future<void> addTask(Task task) async {
    await addTaskUsecase(task);
    state = [...state, task];
    showToastMessage(text: '${task.title} was added successfully.');
  }

  /// Update a task in DB
  Future<void> updateTask(Task task, int index) async {
    await updateTaskUsecase(task);
    state = [
      ...state.sublist(0, index),
      task,
      ...state.sublist(index + 1),
    ];
    showToastMessage(text: '${task.title} was updated successfully.');
  }

  /// Delete a task from DB
  Future<void> deleteTask(String key, int index) async {
    await deleteTaskUsecase(key);
    state = [...state..removeAt(index)];
    showToastMessage(text: 'Task was deleted successfully.');
  }

  /// Mark task as checked or unchecked
  Future<void> toggleTask({
    required Task task,
  }) async {
    await toggleTaskUsecase(task);

    /// Every time you check or uncheck a task nothing changes here but the UI will still
    /// get updated and this is only because every time we get all tasks out of Hive DB
    state = [...state];
  }

  void getFilteredTasks(TasksType type) {
    switch (tasksType) {
      case TasksType.all:
        state = getAllTasksUsecase.getAllTasks();
        break;
      case TasksType.done:
        state = getAllTasksUsecase
            .getAllTasks()
            .where((task) => task.isDone == true)
            .toList();
        break;
      case TasksType.notDone:
        state = getAllTasksUsecase
            .getAllTasks()
            .where((task) => task.isDone == false)
            .toList();
        break;
    }
  }
}

final tasksProvider =
    StateNotifierProvider.autoDispose<TasksProvider, List<Task>>(
  (ref) => TasksProvider(
    addTaskUsecase: locator(),
    deleteTaskUsecase: locator(),
    updateTaskUsecase: locator(),
    toggleTaskUsecase: locator(),
    getAllTasksUsecase: locator(),
  ),
);
