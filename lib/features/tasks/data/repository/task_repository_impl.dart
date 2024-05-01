import 'package:planner/features/tasks/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/usecase/usecases.dart';
import '/features/tasks/data/data_source/local/tasks_database.dart';
import '/features/tasks/domain/entities/task.dart';
import '/features/tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  @override
  Future<void> addTask(Task task) async {
    await TasksDatabase.instance.insertTask(task: task);
  }

  @override
  Future<void> updateTask(Task task) async {
    await TasksDatabase.instance.updateTask(task: task);
  }

  @override
  Future<void> deleteTask(int id) async {
    await TasksDatabase.instance.deleteTask(id: id);
  }

  @override
  Future<void> markTaskAsCompleted(MarkTaskAsCompletedParams params) async {
    await TasksDatabase.instance.markTaskAsCompleted(
      id: params.id,
      isCompleted: params.isCompleted,
    );
  }

  @override
  Future<Task> getTask(String id) async {
    return TasksDatabase.instance.getATaskById(id: id);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final listOfTasks = await TasksDatabase.instance.getAllTasks();
    return listOfTasks;
  }

  @override
  Future<List<Task>> getActiveTasks() async {
    return TasksDatabase.instance.getActiveTasks();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    return TasksDatabase.instance.getCompletedTasks();
  }

  @override
  Future<void> sortTasks(bool isDescending) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.isDesending, isDescending);
  }
}
