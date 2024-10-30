



import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

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
//
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
//     // List of units to insert
//     List<Map<String, String>> units = [
//       {'unit_label': 'Time', 'unit_value': 'minutes'},
//       {'unit_label': 'Pages', 'unit_value': 'pages'},
//       {'unit_label': 'Kilometers', 'unit_value': 'km'},
//       {'unit_label': 'Questions', 'unit_value': 'q/a'},
//       {'unit_label': 'Miles', 'unit_value': 'm'},
//       {'unit_label': 'None', 'unit_value': ''},
//     ];
//
//     // Insert each unit into the units table
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
//   // Method to insert a new task
//   Future<int> insertTask(String task, int unitId) async {
//     final db = await database;
//     return await db.insert(
//       tableTasks,
//       {
//         columnTask: task,
//         columnUnitId: unitId,
//       },
//     );
//   }
//
//   // Method to insert a new task track
//   Future<int> insertTrackTask(int taskId) async {
//     final db = await database;
//     return await db.insert(
//       tableTaskTrack,
//       {
//         columnTaskId: taskId,
//         columnTrackedDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//       },
//     );
//   }
//
//   // Method to delete a task tracking record
//   Future<void> deleteTrackTask(int taskId, String? trackedDate) async {
//
//     final db = await database;
//     if(trackedDate != null ){
//       await db.delete(
//         tableTaskTrack,
//         // where: '$columnTaskId = ?',
//         // whereArgs: [taskId],
//         where: '$columnTaskId = ? AND $columnTrackedDate = ?',
//         whereArgs: [taskId, trackedDate],
//       );
//
//     }else{
//       await db.delete(
//         tableTaskTrack,
//         // where: '$columnTaskId = ?',
//         // whereArgs: [taskId],
//         where: '$columnTaskId = ?',
//         whereArgs: [taskId],
//       );
//     }
//
//   }
//
//   // Method to delete a task
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
//   // Check if a task is tracked for a specific date
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
//   // Fetch all tasks
//   Future<List<Map<String, dynamic>>> getTasks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> tasks = await db.query(tableTasks);
//     print('Tasks fetched from database: $tasks');
//     return tasks;
//   }
//
//   // Method to fetch unit ID by label
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
//       return null; //if no matching unit found
//     }
//   }
//
//
//   // Fetch all units
//   Future<List<Map<String, dynamic>>> getUnits() async {
//     final db = await database;
//     final List<Map<String, dynamic>> units = await db.query(tableUnits);
//     print('Units fetched from database: $units');
//     return units;
//   }
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



  // Future<int> insertTask(String task, int unitId, int target) async {
  //   final db = await database;
  //
  //   final unitResult = await db.query(
  //     tableUnits,
  //     where: '$columnUnitId = ?',
  //     whereArgs: [unitId],
  //   );
  //
  //   String unitValue = '';
  //   if (unitResult.isNotEmpty) {
  //     unitValue = unitResult.first[columnUnitLabel] as String;
  //   }
  //
  //   if (unitValue == 'Time') {
  //     // Convert target from hours to minutes
  //     target = target * 60; // Assuming target is in hours, convert to minutes
  //   }
  //
  //   // Construct the target with the unit
  //   String targetWithUnit = '$target';
  //   // If you want to include the unit value, uncomment the line below
  //   // ' $unitValue';
  //
  //   return await db.insert(
  //     tableTasks,
  //     {
  //       columnTask: task,
  //       columnUnitId: unitId,
  //       columnTarget: targetWithUnit,
  //     },
  //   );
  // }

  Future<int> insertTask(String task, int unitId, int target) async {
    final db = await database;

    // Fetch the unit value based on the unitId
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
      // Convert target from hours to minutes only for Time unit
      target = target * 60; // Convert hours to minutes
    }

    // Construct the target with the unit value if needed
    // Since we only save the target value directly, we don't need to format it here
    return await db.insert(
      tableTasks,
      {
        columnTask: task,
        columnUnitId: unitId,
        columnTarget: target, // Save the target directly
      },
    );
  }



  // Method to insert a new task track
  Future<int> insertTrackTask(int taskId) async {
    final db = await database;
    return await db.insert(
      tableTaskTrack,
      {
        columnTaskId: taskId,
        columnTrackedDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      },
    );
  }

  // Method to delete a task tracking record
  Future<void> deleteTrackTask(int taskId, String? trackedDate) async {

    final db = await database;
    if(trackedDate != null ){
      await db.delete(
        tableTaskTrack,
        // where: '$columnTaskId = ?',
        // whereArgs: [taskId],
        where: '$columnTaskId = ? AND $columnTrackedDate = ?',
        whereArgs: [taskId, trackedDate],
      );

    }else{
      await db.delete(
        tableTaskTrack,
        // where: '$columnTaskId = ?',
        // whereArgs: [taskId],
        where: '$columnTaskId = ?',
        whereArgs: [taskId],
      );
    }

  }

  // Method to delete a task
  Future<void> deleteTask(int taskId) async {
    final db = await database;

    await db.delete(
      tableTasks,
      where: '$columnId = ?',
      whereArgs: [taskId],
    );
  }

  // Check if a task is tracked for a specific date
  Future<bool> isTaskTrackedForDate(int taskId, String trackedDate) async {
    final db = await database;
    final result = await db.query(
      tableTaskTrack,
      where: '$columnTaskId = ? AND $columnTrackedDate = ?',
      whereArgs: [taskId, trackedDate],
    );
    return result.isNotEmpty;
  }




  // Fetch all tasks
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query(tableTasks);
    print('Tasks fetched from database: $tasks');
    return tasks;
  }

  // Method to fetch unit ID by label
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

    // Query to join tasks and units tables
    final result = await db.rawQuery('''
    SELECT t.$columnTarget, u.$columnUnitValue 
    FROM $tableTasks t
    JOIN $tableUnits u ON t.$columnUnitId = u.$columnUnitId
    WHERE t.$columnId = ?
  ''', [taskId]);

    // If a record is found, return the target value and unit value
    if (result.isNotEmpty) {
      return {
        'target': result.first[columnTarget], // The target value from tasks table
        'unit_value': result.first[columnUnitValue], // The unit value from units table
      };
    }
    return null; // Return null if no record is found
  }



}
