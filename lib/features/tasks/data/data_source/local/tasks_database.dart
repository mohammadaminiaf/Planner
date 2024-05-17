import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '/features/tasks/constants/constants.dart';
import '/features/tasks/domain/entities/task.dart';

class TasksDatabase {
  static const String _databaseName = 'tasks.db';
  static const int _databaseVersion = 1;

  // Make this class a singleton
  TasksDatabase._privateConstructor();
  static final TasksDatabase instance = TasksDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  //! Create a DB
  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB,
    );
  }

  Future _createDB(
    Database db,
    int version,
  ) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const nullableTextType = 'TEXT';
    const boolType = 'BOOLEAN NOT NULL';
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tasksTable (
        ${TaskFields.id} $idType,
        ${TaskFields.title} $textType,
        ${TaskFields.description} $textType,
        ${TaskFields.dateCreated} $textType,
        ${TaskFields.dateUpdated} $textType,
        ${TaskFields.isCompleted} $boolType,
        ${TaskFields.notifyAt} $nullableTextType,
        ${TaskFields.priority} $textType,
        ${TaskFields.startDate} $textType,
        ${TaskFields.notificationSchedule} $nullableTextType
      )
        ''');
  }

  //! Insert task method
  Future<Task> insertTask({
    required Task task,
  }) async {
    Database db = await instance.database;
    final id = await db.insert(tasksTable, task.toMap());
    return task.copyWith(id: id);
  }

  //! Update a task
  Future<int> updateTask({required Task task}) async {
    Database db = await instance.database;
    // int id = task.id;

    return await db.update(
      tasksTable,
      task.toMap(), // row
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  //! Delete a task
  Future<int> deleteTask({required int id}) async {
    Database db = await instance.database;

    return await db.delete(
      tasksTable,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  //! Mark a task as Completed
  Future<int> markTaskAsCompleted({
    required int id,
    required bool isCompleted,
  }) async {
    Database db = await instance.database;

    final value = isCompleted ? 1 : 0;

    return await db.rawUpdate(
      'UPDATE $tasksTable SET ${TaskFields.isCompleted} = ? WHERE id = ?',
      [value, id],
    );

    // return await db.update(
    //   tasksTable,
    //   tasks.toMap(),
    //   where: '${TaskFields.isCompleted} = ?',
    //   whereArgs: [id],
    // );
  }

  //! Get a task by ID
  Future<Task> getATaskById({required String id}) async {
    final db = await instance.database;

    final maps = await db.query(
      tasksTable,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      throw Exception('ID $id was not found!');
    }
  }

  //! Get All Tasks method
  Future<List<Task>> getAllTasks() async {
    Database db = await instance.database;
    final prefs = await SharedPreferences.getInstance();

    final isDescending = prefs.getBool(Constants.isDesending);
    final sortType = isDescending == null
        ? 'DESC'
        : isDescending
            ? 'DESC'
            : 'ASC';

    final orderBy = '${TaskFields.startDate} $sortType';

    // final result =
    //     await db.rawQuery('SELECT * FROM $tasksTable ORDER BY $orderBy');
    final result = await db.query(tasksTable, orderBy: orderBy);

    return result.map((map) => Task.fromMap(map)).toList();
  }

  //! Get Active Tasks
  Future<List<Task>> getActiveTasks() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();

    final isDescending = prefs.getBool(Constants.isDesending);
    final sortType = isDescending == null
        ? 'DESC'
        : isDescending
            ? 'DESC'
            : 'ASC';

    final orderBy = '${TaskFields.startDate} $sortType';

    final result = await db.query(
      tasksTable,
      orderBy: orderBy,
      where: '${TaskFields.isCompleted} = ?',
      whereArgs: [0],
    );

    return result.map((taskData) => Task.fromMap(taskData)).toList();
  }

  //! Get Completed Tasks
  Future<List<Task>> getCompletedTasks() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();

    final isDescending = prefs.getBool(Constants.isDesending);
    final sortType = isDescending == null
        ? 'DESC'
        : isDescending
            ? 'DESC'
            : 'ASC';

    final orderBy = '${TaskFields.startDate} $sortType';

    final result = await db.query(
      tasksTable,
      orderBy: orderBy,
      where: '${TaskFields.isCompleted} = ?',
      whereArgs: [1],
    );

    return result.map((taskData) => Task.fromMap(taskData)).toList();
  }
}
