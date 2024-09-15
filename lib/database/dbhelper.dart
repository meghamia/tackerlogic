import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Table names
  static const String tableTasks = 'tasks';
  static const String tableTaskUpdates = 'task_updates';

  // Column names for tasks table
  static const String columnId = 'id';
  static const String columnTask = 'task';
  static const String columnIsChecked = 'is_checked';
  static const String columnProgress = 'progress';
  static const String columnCreatedDate = 'created_date';
  static const String columnUpdatedDate = 'updated_date';
  static const String columnDayName = 'day_name'; // New column for day name

  // Column names for task_updates table
  static const String columnUpdateId = 'id'; // Assuming same ID column
  static const String columnTaskName = 'task_name';
  static const String columnCompleted = 'completed';
  static const String columnUpdateProgress = 'progress';
  static const String columnUpdateDate = 'updated_date';

  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // Database variable
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      'tasks.db',
      version: 2, // Increment the version number if there are schema changes
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE $tableTasks (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTask TEXT,
            $columnIsChecked INTEGER,
            $columnProgress REAL,
            $columnCreatedDate TEXT,
            $columnUpdatedDate TEXT,
            $columnDayName TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE $tableTaskUpdates (
            $columnUpdateId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTaskName TEXT,
            $columnCompleted INTEGER,
            $columnUpdateProgress REAL,
            $columnUpdateDate TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) { // Upgrade to version 2
          // Add the new column to the existing table
          await db.execute(''' 
            ALTER TABLE $tableTasks ADD COLUMN $columnDayName TEXT
          ''');
        }
        // You can add further upgrade logic here for future versions
      },
    );
  }

  // Method to insert a new task
  Future<int> insertTask(String task, bool isChecked, double progress, String createdDate, String updatedDate) async {
    final db = await database;
    return await db.insert(
      tableTasks,
      {
        columnTask: task,
        columnIsChecked: isChecked ? 1 : 0,
        columnProgress: progress,
        columnCreatedDate: createdDate,
        columnUpdatedDate: updatedDate,
        columnDayName: DateFormat('EEEE').format(DateTime.now()), // Add day name
      },
    );
  }

  // Method to update an existing task
  Future<int> updateTask(String oldTask, String newTask, bool isChecked, double progress, String updatedDate) async {
    final db = await database;
    return await db.update(
      tableTasks,
      {
        columnTask: newTask,
        columnIsChecked: isChecked ? 1 : 0,
        columnProgress: progress,
        columnUpdatedDate: updatedDate,
      },
      where: '$columnTask = ?',
      whereArgs: [oldTask],
    );
  }

  // Method to delete a task
  Future<int> deleteTask(String task) async {
    final db = await database;
    return await db.delete(
      tableTasks,
      where: '$columnTask = ?',
      whereArgs: [task],
    );
  }

  // Method to fetch all tasks
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query(tableTasks);
  }

  // Method to insert a new task update
  Future<int> insertTaskUpdate(String taskName, bool isChecked, double progress, String updatedDate) async {
    final db = await database;
    return await db.insert(
      tableTaskUpdates,
      {
        columnTaskName: taskName,
        columnCompleted: isChecked ? 1 : 0,
        columnUpdateProgress: progress,
        columnUpdateDate: updatedDate,
      },
    );
  }



  // Method to fetch task data for a specific week
  Future<List<Map<String, dynamic>>> fetchTaskDataForWeek(String taskName) async {
    final db = await database;
    String endDate = DateTime.now().toIso8601String();
    String startDate = DateTime.now().subtract(Duration(days: 7)).toIso8601String();

    return await db.query(
      tableTaskUpdates,
      where: '$columnTaskName = ? AND $columnUpdateDate BETWEEN ? AND ?',
      whereArgs: [taskName, startDate, endDate],
    );
  }

  // Method to get task history
  Future<List<Map<String, dynamic>>> getTaskHistory(String task) async {
    final db = await database;
    return await db.query(
      tableTaskUpdates,
      where: '$columnTaskName = ?',
      whereArgs: [task],
    );
  }

  // Method to update the day name for a task
  Future<int> updateTaskDayName(String taskName, String dayName) async {
    final db = await database;
    return await db.update(
      tableTasks,
      {
        columnDayName: dayName,
      },
      where: '$columnTask = ?',
      whereArgs: [taskName],
    );
  }

  // Method to fetch task details by task name
  Future<List<Map<String, dynamic>>> getTaskDetails(String taskName) async {
    final db = await database;
    return await db.query(
      tableTasks,
      where: '$columnTask = ?',
      whereArgs: [taskName],
    );
  }
}
