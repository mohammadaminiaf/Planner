// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:planner/features/view_tasks/data/models/tasks_type.dart';

// import '/core/params/toggle_task_param.dart';
// import '/core/params/update_task_param.dart';
// import '/features/add_tasks/domain/entities/task.dart';
// import '/features/add_tasks/domain/usecases/add_task_usecase.dart';
// import '/features/add_tasks/domain/usecases/delete_task_usecase.dart';
// import '/features/add_tasks/domain/usecases/reorder_tasks_usecase.dart';
// import '/features/add_tasks/domain/usecases/toggle_task_usecase.dart';
// import '/features/add_tasks/domain/usecases/update_task_usecase.dart';
// import '/features/view_tasks/domain/usecases/get_all_tasks_usecase.dart';
// import '/locator.dart';

// class TasksProvider extends ChangeNotifier {
//   final AddTaskUsecase addTaskUsecase;
//   final DeleteTaskUsecase deleteTaskUsecase;
//   final UpdateTaskUsecase updateTaskUsecase;
//   final ToggleTaskUsecase toggleTaskUsecase;
//   final GetAllTasksUsecase getAllTasksUsecase;
//   final ReorderTasksUsecase reorderTasksUsecase;

//   late List<Task> _tasks;

//   TasksProvider({
//     required this.addTaskUsecase,
//     required this.deleteTaskUsecase,
//     required this.updateTaskUsecase,
//     required this.toggleTaskUsecase,
//     required this.getAllTasksUsecase,
//     required this.reorderTasksUsecase,
//   }) : super() {
//     _tasks = getFilteredTasks(tasksType);
//   }

//   final int _doneTasks = 0;
//   final int _tasksLength = 0;
//   TasksType _tasksType = TasksType.all;

//   /// Getters
//   List<Task> get tasks => _tasks;
//   TasksType get tasksType => _tasksType;
//   int get doneTasks => _doneTasks;
//   int get tasksLength => _tasksLength;

//   /// every time you set tasksType it gets filtered tasks and put them inside task list
//   set tasksType(TasksType type) {
//     _tasksType = type;
//     _tasks = getFilteredTasks(type);
//     notifyListeners();
//   }

//   /// Add a new task to the DB
//   Future<int> addTask(Task task) async {
//     final result = await addTaskUsecase(task);
//     tasks.add(task);
//     notifyListeners();
//     return result;
//   }

//   /// Update a task in DB
//   Future<void> updateTask(Task task, int index) async {
//     await updateTaskUsecase(UpdateTaskParam(
//       index: index,
//       task: task,
//     ));
//     tasks[index] = task;
//     notifyListeners();
//   }

//   /// Delete a task from DB
//   Future<void> deleteTask(int index) async {
//     deleteTaskUsecase(index);
//     tasks.removeAt(index);
//     notifyListeners();
//   }

//   /// Reorder all tasks
//   void reorderTasks(List<Task> tasks) {
//     reorderTasksUsecase(tasks);
//     notifyListeners();
//   }

//   /// Mark task as checked or unchecked
//   Future<void> toggleTask({
//     required int index,
//     required Task task,
//     required bool isChecked,
//   }) async {
//     await toggleTaskUsecase(
//       ToggleTaskParam(
//         index: index,
//         task: task,
//         isChecked: isChecked,
//       ),
//     );
//     notifyListeners();
//   }

//   List<Task> getFilteredTasks(TasksType type) {
//     switch (tasksType) {
//       case TasksType.all:
//         return getAllTasksUsecase.getAllTasks();
//       case TasksType.done:
//         return getAllTasksUsecase
//             .getAllTasks()
//             .where((task) => task.isDone == true)
//             .toList();
//       case TasksType.notDone:
//         return getAllTasksUsecase
//             .getAllTasks()
//             .where((task) => task.isDone == false)
//             .toList();
//     }
//   }
// }

// final tasksProvider = ChangeNotifierProvider<TasksProvider>(
//   (_) => TasksProvider(
//     addTaskUsecase: locator(),
//     deleteTaskUsecase: locator(),
//     updateTaskUsecase: locator(),
//     toggleTaskUsecase: locator(),
//     getAllTasksUsecase: locator(),
//     reorderTasksUsecase: locator(),
//   ),
// );
