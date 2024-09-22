
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Table names
  static const String tableTasks = 'tasks';
  static const String tableTaskTrack = 'task_tracked';

  // Column names for tasks table
  static const String columnId = 'id';
  static const String columnTask = 'task';
  static const String columnIsTracked = 'is_tracked';
  //static const String columnProgress = 'progress';

  //static const String columnUpdatedDate = 'created_date';

  // Column names for task_tracked table
  static const String columnUpdateId = 'id';
  static const String columnTaskId = 'task_id';
 // static const String columnCompleted = 'completed';
 // static const String columnUpdateProgress = 'progress';
  static const String columnTrackedDate = 'tracked_date';

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
            $columnTask TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE $tableTaskTrack (
            $columnUpdateId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTaskId INTEGER,
            $columnTrackedDate TEXT
          )
        ''');
      },
      // onUpgrade: (db, oldVersion, newVersion) async {
      //   if (oldVersion < 2) {
      //     // Upgrade to version 2
      //     // Add the new column to the existing table
      //     await db.execute('''
      //       ALTER TABLE $tableTasks ADD COLUMN $columnDayName TEXT
      //     ''');
      //   }
      //   // You can add further upgrade logic here for future versions
      // },
    );
  }

  // Method to insert a new task
  Future<int> insertTask(String task) async {
    final db = await database;
    return await db.insert(
      tableTasks,
      {
        columnTask: task,
        // columnTrackedDate :  DateFormat('DD-MM-YYYY').format(DateTime.now()), // Add day name

        // columnIsChecked: isChecked ? 1 : 0,
        // columnProgress: progress,
        // columnTrackedDate:  DateFormat('DD-MM-YYYY').format(DateTime.now()), // Add day name

        // columnDayName:
        // DateFormat('EEEE').format(DateTime.now()), // Add day name
      },
    );
  }




  // Method to insert a new task update
  Future<int> insertTrackTask(int id) async {
    final db = await database;
    return await db.insert(
      tableTaskTrack,
      {
        columnTaskId: id,
        columnTrackedDate :  DateFormat('dd-MM-yyyy').format(DateTime.now()),


        //columnCompleted: isChecked ? 1 : 0,
        //columnUpdateProgress: progress,
        //columnUpdateDate: updatedDate,
      },

    );


  }

  // Method to update an existing task
  // Future<int> updateTask(String oldTask, String newTask, bool isChecked,
  //     double progress, String updatedDate) async {
  //   final db = await database;
  //   return await db.update(
  //     tableTasks,
  //     {
  //       columnTask: newTask,
  //       columnIsChecked: isChecked ? 1 : 0,
  //       columnProgress: progress,
  //       columnUpdatedDate: updatedDate,
  //     },
  //     where: '$columnTask = ?',
  //     whereArgs: [oldTask],
  //   );
  // }

  // Method to delete a task
  Future<void> deleteTrackTask(int taskId,String trackedDate) async {
    final db = await database;

    // await db.delete(
    //   tableTasks,
    //   where: '$columnId = ?',
    //   whereArgs: [taskId],
    // );


    await db.delete(
      tableTaskTrack,
      where: '$columnTaskId = ? AND $columnTrackedDate = ?',
      whereArgs: [taskId,trackedDate],
    );
  }

  Future<void> deleteTask(int taskId) async {
    final db = await database;
    await db.delete(
      tableTasks,
      where: '$columnId = ?',
      whereArgs : [taskId],
    );
  }

  Future<bool> isTaskTrackedForDate(int taskId, String trackedDate) async {
    final db = await database;
    final result = await db.query(
      tableTaskTrack,
      where: '$columnTaskId = ? AND $columnTrackedDate = ?',
      whereArgs: [taskId, trackedDate],
    );
    return result.isNotEmpty;
  }


  // Method to fetch all tasks
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query(tableTasks);
  }

  // Future<List<Map<String,dynamic>>> getTrackTask(String date,int id) async{
  //   final db = await database;
  //   // return await db.query(tableTasks);
  //   return await db.query(
  //           tableTaskTrack,
  //           where: '$columnTaskId = ? AND $columnTrackedDate = ?',
  //           whereArgs: [id,date],
  //         );
  //
  // }



  // // Method to fetch task data for a specific week
  // Future<List<Map<String, dynamic>>> fetchTaskDataForWeek(
  //     String taskName) async {
  //   final db = await database;
  //   String endDate = DateTime.now().toIso8601String();
  //   String startDate =
  //       DateTime.now().subtract(Duration(days: 7)).toIso8601String();
  //
  //   return await db.query(
  //     tableTaskUpdates,
  //     where: '$columnTaskName = ? AND $columnUpdateDate BETWEEN ? AND ?',
  //     whereArgs: [taskName, startDate, endDate],
  //   );
  // }

  // Method to get task history
  // Future<List<Map<String, dynamic>>> getTaskHistory(String task) async {
  //   final db = await database;
  //   return await db.query(
  //     tableTaskUpdates,
  //     where: '$columnTaskName = ?',
  //     whereArgs: [task],
  //   );
  // }

  // // Method to update the day name for a task
  // Future<int> updateTaskDayName(String taskName, String dayName) async {
  //   final db = await database;
  //   return await db.update(
  //     tableTasks,
  //     {
  //       columnDayName: dayName,
  //     },
  //     where: '$columnTask = ?',
  //     whereArgs: [taskName],
  //   );
  // }

  // Method to fetch task details by task name
  // Future<List<Map<String, dynamic>>> getTaskDetails(String taskName) async {
  //   final db = await database;
  //   return await db.query(
  //     tableTasks,
  //     where: '$columnTask = ?',
  //     whereArgs: [taskName],
  //   );
  // }




}
