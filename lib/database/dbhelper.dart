
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   // Table names
//   static const String tableTasks = 'tasks';
//   static const String tableTaskTrack = 'task_tracked';
//   static const String tableUnits = 'units';
//
//   // Column names for tasks table
//   static const String columnId = 'id';
//   static const String columnTask = 'task';
//   static const String columnUnitId = 'unit_id';
//   static const String columnTarget = 'target';
//   static const String columnStartTime = 'start_time';
//   static const String columnEndTime = 'end_time';
//
//   // Column names for task_tracked table
//   static const String columnUpdateId = 'id';
//   static const String columnTaskId = 'task_id';
//   static const String columnTrackedDate = 'tracked_date';
//
//   // Column names for units table
//   static const String columnUnitLabel = 'unit_label';
//   static const String columnUnitValue = 'unit_value';
//
//   // Singleton pattern
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();
//
//   // Database variable
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     return openDatabase(
//       'tasks.db',
//       version: 2,
//       onCreate: (db, version) async {
//         // Create tasks table
//         await db.execute('''
//           CREATE TABLE $tableTasks (
//             $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//             $columnTask TEXT,
//             $columnUnitId INTEGER,
//             $columnTarget INTEGER,
//             FOREIGN KEY($columnUnitId) REFERENCES $tableUnits($columnUnitId)
//           )
//         ''');
//
//         // Create task_tracked table
//         await db.execute('''
//           CREATE TABLE $tableTaskTrack (
//             $columnUpdateId INTEGER PRIMARY KEY AUTOINCREMENT,
//             $columnTaskId INTEGER,
//             $columnTrackedDate TEXT,
//             $columnStartTime TEXT,
//             $columnEndTime TEXT,
//             FOREIGN KEY($columnTaskId) REFERENCES $tableTasks($columnId)
//           )
//         ''');
//
//         // Create units table
//         await db.execute('''
//           CREATE TABLE $tableUnits (
//             $columnUnitId INTEGER PRIMARY KEY AUTOINCREMENT,
//             $columnUnitLabel TEXT,
//             $columnUnitValue TEXT
//           )
//         ''');
//
//         // Insert static units into the units table
//         await _insertStaticUnits(db);
//       },
//     );
//   }
//
//   Future<void> _insertStaticUnits(Database db) async {
//     List<Map<String, String>> units = [
//       {'unit_label': 'Time', 'unit_value': 'minutes'},
//       {'unit_label': 'Pages', 'unit_value': 'pages'},
//       {'unit_label': 'Kilometers', 'unit_value': 'km'},
//       {'unit_label': 'Questions', 'unit_value': 'q/a'},
//       {'unit_label': 'Miles', 'unit_value': 'm'},
//       {'unit_label': 'None', 'unit_value': ''},
//     ];
//
//     for (var unit in units) {
//       await db.insert(
//         tableUnits,
//         {
//           columnUnitLabel: unit['unit_label']!,
//           columnUnitValue: unit['unit_value']!,
//         },
//       );
//     }
//   }
//
//   // Future<int> insertTask(String task, int unitId, int target) async {
//   //   final db = await database;
//   //
//   //   final unitResult = await db.query(
//   //     tableUnits,
//   //     where: '$columnUnitId = ?',
//   //     whereArgs: [unitId],
//   //   );
//   //
//   //   String unitValue = '';
//   //   if (unitResult.isNotEmpty) {
//   //     unitValue = unitResult.first[columnUnitLabel] as String;
//   //   }
//   //
//   //   if (unitValue == 'Time') {
//   //     // Convert target from hours to minutes
//   //     target = target * 60; // Assuming target is in hours, convert to minutes
//   //   }
//   //
//   //   // Construct the target with the unit
//   //   String targetWithUnit = '$target';
//   //   // If you want to include the unit value, uncomment the line below
//   //   // ' $unitValue';
//   //
//   //   return await db.insert(
//   //     tableTasks,
//   //     {
//   //       columnTask: task,
//   //       columnUnitId: unitId,
//   //       columnTarget: targetWithUnit,
//   //     },
//   //   );
//   // }
//
//   // Future<int> insertTask(String task, int unitId, int target) async {
//   //   final db = await database;
//   //
//   //   final unitResult = await db.query(
//   //     tableUnits,
//   //     where: '$columnUnitId = ?',
//   //     whereArgs: [unitId],
//   //   );
//   //
//   //   String unitValue = '';
//   //   if (unitResult.isNotEmpty) {
//   //     unitValue = unitResult.first[columnUnitLabel] as String;
//   //   }
//   //
//   //   if (unitValue == 'Time') {
//   //     target = target * 60; // Convert hours to minutes
//   //   }
//   //   return await db.insert(
//   //     tableTasks,
//   //     {
//   //       columnTask: task,
//   //       columnUnitId: unitId,
//   //       columnTarget: target,
//   //     },
//   //   );
//   // }
//
//   Future<int> insertTask(String task, int unitId, int target) async {
//     final db = await database;
//
//     final unitResult = await db.query(
//       tableUnits,
//       where: '$columnUnitId = ?',
//       whereArgs: [unitId],
//     );
//
//     String unitValue = '';
//     if (unitResult.isNotEmpty) {
//       unitValue = unitResult.first[columnUnitLabel] as String;
//     }
//
//     if (unitValue == 'Time') {
//       target = target * 60; // Convert hours to minutes
//     }
//
//     return await db.insert(
//       tableTasks,
//       {
//         columnTask: task,
//         columnUnitId: unitId,
//         columnTarget: target,
//       },
//     );
//   }
//
//   // Method to insert a new task track
//   Future<int> insertTrackTask({
//     required int taskId,
//     required DateTime startTime,
//     DateTime? endTime,
//   }) async {
//     final db = await database;
//
//     String formatDateTime(DateTime dateTime) {
//       return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
//     }
//
//     return await db.insert(
//       tableTaskTrack,
//       {
//         columnTaskId: taskId,
//         columnTrackedDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         columnStartTime: formatDateTime(startTime),
//         columnEndTime: endTime != null ? formatDateTime(endTime) : null,
//       },
//     );
//   }
//
//   // Method to delete a task tracking record
//   Future<void> deleteTrackTask(int taskId, String? trackedDate) async {
//     final db = await database;
//     if (trackedDate != null) {
//       await db.delete(
//         tableTaskTrack,
//         // where: '$columnTaskId = ?',
//         // whereArgs: [taskId],
//         where: '$columnTaskId = ? AND $columnTrackedDate = ?',
//         whereArgs: [taskId, trackedDate],
//       );
//     } else {
//       await db.delete(
//         tableTaskTrack,
//         // where: '$columnTaskId = ?',
//         // whereArgs: [taskId],
//         where: '$columnTaskId = ?',
//         whereArgs: [taskId],
//       );
//     }
//   }
//
//   Future<void> deleteTask(int taskId) async {
//     final db = await database;
//
//     await db.delete(
//       tableTasks,
//       where: '$columnId = ?',
//       whereArgs: [taskId],
//     );
//   }
//
//   Future<bool> isTaskTrackedForDate(int taskId, String trackedDate) async {
//     final db = await database;
//     final result = await db.query(
//       tableTaskTrack,
//       where: '$columnTaskId = ? AND $columnTrackedDate = ?',
//       whereArgs: [taskId, trackedDate],
//     );
//     return result.isNotEmpty;
//   }
//
//   Future<List<Map<String, dynamic>>> getTasks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> tasks = await db.query(tableTasks);
//     print('Tasks fetched from database: $tasks');
//     return tasks;
//   }
//
//   Future<int?> fetchUnitIdByLabel(String unitLabel) async {
//     final db = await database;
//     final List<Map<String, dynamic>> result = await db.query(
//       tableUnits,
//       where: '$columnUnitLabel = ?',
//       whereArgs: [unitLabel],
//     );
//
//     if (result.isNotEmpty) {
//       return result.first[columnUnitId] as int;
//     } else {
//       return null;
//     }
//   }
//
//   // Fetch all units
//   Future<List<Map<String, dynamic>>> getUnits() async {
//     final db = await database;
//     final List<Map<String, dynamic>> units = await db.query(tableUnits);
//     print('Units fetched from database: $units');
//     return units;
//   }
//
//   Future<Map<String, dynamic>?> getTargetValue(int taskId) async {
//     final db = await database;
//
//     final result = await db.rawQuery('''
//     SELECT t.$columnTarget, u.$columnUnitValue
//     FROM $tableTasks t
//     JOIN $tableUnits u ON t.$columnUnitId = u.$columnUnitId
//     WHERE t.$columnId = ?
//   ''', [taskId]);
//
//     if (result.isNotEmpty) {
//       return {
//         'target': result.first[columnTarget],
//         'unit_value': result.first[columnUnitValue],
//       };
//     }
//     return null;
//   }
//
//   Future<List<Map<String, dynamic>>> getTimeLapseForTask(int taskId) async {
//     final db = await database;
//
//     String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//     final result = await db.query(
//       tableTaskTrack,
//       where: '$columnTaskId = ? AND $columnTrackedDate = ?',
//       whereArgs: [taskId, todayDate],
//     );
//
//     return result;
//   }
//
//   Future<int?> getTargetDurationForTask(int taskId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> result = await db.query(
//       tableTasks,
//       where: '$columnId = ?',
//       whereArgs: [taskId],
//     );
//     if (result.isNotEmpty) {
//       return result.first[columnTarget] as int;
//     } else {
//       return null;
//     }
//   }
//
//   // Future<Map<String, String?>> getLastTaskTrack(int taskId) async {
//   //   final db = await database;
//   //
//   //   String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   //
//   //   // Query the latest task track for today
//   //   final result = await db.query(
//   //     tableTaskTrack,
//   //     where: '$columnTaskId = ? AND $columnTrackedDate = ?',
//   //     whereArgs: [taskId, todayDate],
//   //     orderBy: '$columnUpdateId DESC',  // Assuming you want the most recent entry
//   //     limit: 1,  // Fetch only the latest record
//   //   );
//   //
//   //   if (result.isNotEmpty) {
//   //     // Safely extract values, casting from Object? to String?
//   //     return {
//   //       'start_time': result.first[columnStartTime] as String?,
//   //       'end_time': result.first[columnEndTime] as String?,
//   //     };
//   //   } else {
//   //     // Return an empty map or handle the case where no record is found
//   //     return {
//   //       'start_time': null,
//   //       'end_time': null,
//   //     };
//   //   }
//   // }
//
//   Future<String?> getLastStartTime(int taskId) async {
//     final db = await database;
//
//     // Query the task_tracked table for the start time based on the taskId and order by columnUpdateId
//     final result = await db.query(
//       tableTaskTrack,
//       where: '$columnTaskId = ?',
//       whereArgs: [taskId],
//       orderBy: '$columnUpdateId DESC',  // Sort by the unique update ID in descending order
//       limit: 1,  // Only fetch the most recent record
//     );
//
//     if (result.isNotEmpty) {
//       // If a record is found, return the start time
//       return result.first[columnStartTime] as String?;
//     }
//
//     // If no records are found, return null
//     return null;
//   }
//
//
//   // Future<String?> getStartTimeForTask(int taskId) async {
//   //   final db = await database;
//   //   var result = await db.query(
//   //     tableTaskTrack,
//   //     where: '$columnTaskId = ?',
//   //     whereArgs: [taskId],
//   //   );
//   //
//   //   if (result.isNotEmpty) {
//   //     return result.first[columnStartTime] as String?;
//   //   }
//   //
//   //   return null;
//   // }
//   Future<Duration?> calculateElapsedTime(int taskId) async {
//     final db = await database;
//
//     // Query the task_tracked table for the start and end times
//     final result = await db.query(
//       tableTaskTrack,
//       columns: [columnStartTime, columnEndTime],
//       where: '$columnTaskId = ?',
//       whereArgs: [taskId],
//       orderBy: '$columnUpdateId DESC', // Fetch the latest entry
//       limit: 1,
//     );
//
//     if (result.isNotEmpty) {
//       final String? startTimeStr = result.first[columnStartTime] as String?;
//       final String? endTimeStr = result.first[columnEndTime] as String?;
//
//       if (startTimeStr != null && endTimeStr != null) {
//         // Parse the times into DateTime objects
//         final startTime = DateFormat.Hms().parse(startTimeStr);
//         final endTime = DateFormat.Hms().parse(endTimeStr);
//
//         // Calculate the elapsed time
//         return endTime.difference(startTime);
//       }
//     }
//
//     // Return null if no valid start and end times are found
//     return null;
//   }
//
// // Future<String?> getStartDateForTask(int taskId) async {
//   //   final db = await database;
//   //   var result = await db.query(
//   //     tableTaskTrack,
//   //     where: '$columnTaskId = ?',
//   //     whereArgs: [taskId],
//   //   );
//   //
//   //   if (result.isNotEmpty) {
//   //     return result.first[columnTrackedDate] as String?;
//   //   }
//   //
//   //   return null;
//   // }
// }




class DatabaseHelper {
  // Table names
  static const String tableTasks = 'tasks';
  static const String tableTaskTrack = 'task_tracked';
  static const String tableUnits = 'units';

  // Column names for tasks table
  static const String columnId = 'id';
  static const String columnTask = 'task';
  static const String columnUnitId = 'unit_id';
  static const String columnTarget = 'target';
  static const String columnStartTime = 'start_time';
  static const String columnEndTime = 'end_time';

  // Column names for task_tracked table
  static const String columnUpdateId = 'id';
  static const String columnTaskId = 'task_id';
  static const String columnTrackedDate = 'tracked_date';

  // Column names for units table
  static const String columnUnitLabel = 'unit_label';
  static const String columnUnitValue = 'unit_value';

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
      version: 2,
      onCreate: (db, version) async {
        // Create tasks table
        await db.execute('''
          CREATE TABLE $tableTasks (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTask TEXT,
            $columnUnitId INTEGER,
            $columnTarget INTEGER,
            FOREIGN KEY($columnUnitId) REFERENCES $tableUnits($columnUnitId)
          )
        ''');

        // Create task_tracked table
        await db.execute('''
          CREATE TABLE $tableTaskTrack (
            $columnUpdateId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTaskId INTEGER,
            $columnTrackedDate TEXT,
            $columnStartTime TEXT,
            $columnEndTime TEXT,
            FOREIGN KEY($columnTaskId) REFERENCES $tableTasks($columnId)
          )
        ''');

        // Create units table
        await db.execute('''
          CREATE TABLE $tableUnits (
            $columnUnitId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnUnitLabel TEXT,
            $columnUnitValue TEXT
          )
        ''');

        // Insert static units into the units table
        await _insertStaticUnits(db);
      },
    );
  }

  Future<void> _insertStaticUnits(Database db) async {
    List<Map<String, String>> units = [
      {'unit_label': 'Time', 'unit_value': 'minutes'},
      {'unit_label': 'Pages', 'unit_value': 'pages'},
      {'unit_label': 'Kilometers', 'unit_value': 'km'},
      {'unit_label': 'Questions', 'unit_value': 'q/a'},
      {'unit_label': 'Miles', 'unit_value': 'm'},
      {'unit_label': 'None', 'unit_value': ''},
    ];

    for (var unit in units) {
      await db.insert(
        tableUnits,
        {
          columnUnitLabel: unit['unit_label']!,
          columnUnitValue: unit['unit_value']!,
        },
      );
    }
  }


  Future<int> insertTask(String task, int unitId, int target) async {
    final db = await database;

    final unitResult = await db.query(
      tableUnits,
      where: '$columnUnitId = ?',
      whereArgs: [unitId],
    );

    String unitValue = '';
    if (unitResult.isNotEmpty) {
      unitValue = unitResult.first[columnUnitLabel] as String;
    }

    if (unitValue == 'Time') {
      target = target * 60; // Convert hours to minutes
    }

    return await db.insert(
      tableTasks,
      {
        columnTask: task,
        columnUnitId: unitId,
        columnTarget: target,
      },
    );
  }

  // Method to insert a new task track
  Future<int> insertTrackTask({
    required int taskId,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    final db = await database;

    String formatDateTime(DateTime dateTime) {
      return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    }

    return await db.insert(
      tableTaskTrack,
      {
        columnTaskId: taskId,
        columnTrackedDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        columnStartTime: formatDateTime(startTime),
        columnEndTime: endTime != null ? formatDateTime(endTime) : null,
      },
    );
  }

  // Method to delete a task tracking record
  Future<void> deleteTrackTask(int taskId, String? trackedDate) async {
    final db = await database;
    if (trackedDate != null) {
      await db.delete(
        tableTaskTrack,
        // where: '$columnTaskId = ?',
        // whereArgs: [taskId],
        where: '$columnTaskId = ? AND $columnTrackedDate = ?',
        whereArgs: [taskId, trackedDate],
      );
    } else {
      await db.delete(
        tableTaskTrack,
        // where: '$columnTaskId = ?',
        // whereArgs: [taskId],
        where: '$columnTaskId = ?',
        whereArgs: [taskId],
      );
    }
  }

  Future<void> deleteTask(int taskId) async {
    final db = await database;

    await db.delete(
      tableTasks,
      where: '$columnId = ?',
      whereArgs: [taskId],
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

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query(tableTasks);
    print('Tasks fetched from database: $tasks');
    return tasks;
  }

  Future<int?> fetchUnitIdByLabel(String unitLabel) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      tableUnits,
      where: '$columnUnitLabel = ?',
      whereArgs: [unitLabel],
    );

    if (result.isNotEmpty) {
      return result.first[columnUnitId] as int;
    } else {
      return null;
    }
  }

  // Fetch all units
  Future<List<Map<String, dynamic>>> getUnits() async {
    final db = await database;
    final List<Map<String, dynamic>> units = await db.query(tableUnits);
    print('Units fetched from database: $units');
    return units;
  }

  Future<Map<String, dynamic>?> getTargetValue(int taskId) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT t.$columnTarget, u.$columnUnitValue
    FROM $tableTasks t
    JOIN $tableUnits u ON t.$columnUnitId = u.$columnUnitId
    WHERE t.$columnId = ?
  ''', [taskId]);

    if (result.isNotEmpty) {
      return {
        'target': result.first[columnTarget],
        'unit_value': result.first[columnUnitValue],
      };
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getTimeLapseForTask(int taskId) async {
    final db = await database;

    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final result = await db.query(
      tableTaskTrack,
      where: '$columnTaskId = ? AND $columnTrackedDate = ?',
      whereArgs: [taskId, todayDate],
    );

    return result;
  }

  Future<int?> getTargetDurationForTask(int taskId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      tableTasks,
      where: '$columnId = ?',
      whereArgs: [taskId],
    );
    if (result.isNotEmpty) {
      return result.first[columnTarget] as int;
    } else {
      return null;
    }
  }


  Future<Duration?> calculateElapsedTime(int taskId) async {
    final db = await database;

    final result = await db.query(
      tableTaskTrack,
      columns: [columnStartTime, columnEndTime],
      where: '$columnTaskId = ?',
      whereArgs: [taskId],
      orderBy: '$columnUpdateId DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      final String? startTimeStr = result.first[columnStartTime] as String?;
      final String? endTimeStr = result.first[columnEndTime] as String?;

      if (startTimeStr != null && endTimeStr != null) {
        final startTime = DateFormat.Hms().parse(startTimeStr);
        final endTime = DateFormat.Hms().parse(endTimeStr);

        // Calculate the elapsed time
        return endTime.difference(startTime);
      }
    }

    return null;
  }

}
