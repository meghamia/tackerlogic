// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../database/dbhelper.dart';
//
// import 'package:intl/intl.dart';
//
// class TaskController extends GetxController {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();
//   var taskList = <String>[].obs;
//   var isTaskSelected = <bool>[].obs;
//   List<double> progressData = List<double>.filled(7, 0.0);
//   var completionDates = <String, bool>{}.obs;
//   var taskDateMapping = <String, List<int>>{}.obs;
//   var taskIdList = <int>[].obs;
//   var pinnedTasks = <String>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//    // loadPinnedTasks();
//   }
//
//   Future<List<bool>> loadTasks() async {
//     List<bool> taskStatusList = [];
//     try {
//       final tasks = await _databaseHelper.getTasks();
//       print('Tasks retrieved: $tasks');
//       taskList.value = tasks.map((task) => task[DatabaseHelper.columnTask] as String).toList();
//       taskIdList.value = tasks.map((task) => task[DatabaseHelper.columnId] as int).toList();
//       isTaskSelected.value = List<bool>.filled(taskList.length, false);
//
//       String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//       // taskIdList.asMap().entries.forEach((MapEntry<int, int> entry) async {
//       //   bool isTracked = await _databaseHelper.isTaskTrackedForDate(entry.value, trackedDate);
//       //   isTaskSelected[entry.key] = isTracked;
//       // });
//
//       for (var i = 0; i < taskIdList.length; i++) {
//         bool isTracked = await _databaseHelper.isTaskTrackedForDate(
//             taskIdList[i], trackedDate);
//         isTaskSelected[i] = isTracked;
//         taskStatusList.add(isTracked);
//       }
//        await loadPinnedTasks();
//
//       print('Loaded Tasks: ${taskList.value}');
//       print('Is Task Selected: ${isTaskSelected.value}');
//       print('Task Status List : $taskStatusList');
//       return taskStatusList;
//     } catch (e) {
//       print("Error loading tasks: $e");
//       return [];
//     }
//   }
//
//   Future<void> loadPinnedTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String>? savedPinnedTasks = prefs.getStringList('pinnedTasks');
//
//     if (savedPinnedTasks != null && savedPinnedTasks.isNotEmpty) {
//       pinnedTasks.value = savedPinnedTasks;
//
//       // Re-order the task list based on pinned tasks
//       for (var task in pinnedTasks) {
//         if (taskList.contains(task)) {
//           taskList.remove(task);
//           taskList.insert(0, task);
//         }
//       }
//       print('Pinned tasks re-ordered: $savedPinnedTasks');
//     }
//   }
//
//   Future<void> addTask(String task) async {
//     try {
//       int result = await _databaseHelper.insertTask(task);
//
//       loadTasks();
//     } catch (e) {
//       print("Error adding task: $e");
//     }
//   }
//
//   Future<void> toggleTaskStatus(int id) async {
//     print("toggleTaskStatus called with id: $id");
//
//     try {
//       final db = await DatabaseHelper().database;
//       print("Database accessed succfully");
//
//       int updateId = await db.insert(
//         DatabaseHelper.tableTaskTrack,
//         {
//           DatabaseHelper.columnTaskId: id,
//           DatabaseHelper.columnTrackedDate:
//               DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         },
//       );
//
//       print(
//           "Inserted task tracking with update_id: $updateId for task_id: $id.");
//     } catch (e) {
//       print("Error tracking task status for task $id: $e");
//     }
//   }
//
//   void deleteTrackTask(int index) async {
//     try {
//       int taskId = taskIdList[index];
//       String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//       await _databaseHelper.deleteTrackTask(taskId, trackedDate);
//       //isTaskSelected.removeAt(index);
//     } catch (e) {
//       print("Error deleting task: $e");
//     }
//   }
//
//   void deleteTask(int index) async {
//     try {
//       int taskId = taskIdList[index];
//
//       await _databaseHelper.deleteTask(taskId);
//       taskList.removeAt(index);
//       //isTaskSelected.removeAt(index);
//     } catch (e) {
//       print("Error deleting task: $e");
//     }
//   }
//
//   Future<void> toggleTaskSelection(int index, bool value) async {
//     try {
//       if (index < 0 || index >= taskList.length) {
//         throw ArgumentError("Index out of range");
//       }
//
//       String taskToUpdate = taskList[index];
//       double progress = value ? 1.0 : 0.0;
//       String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//       int taskId = taskIdList[index];
//
//       isTaskSelected[index] = value;
//
//       if (value == true) {
//         await _databaseHelper.insertTrackTask(taskId);
//         print('Task with ID: $taskId has already been tracked for $trackedDate.');
//       } else {
//         deleteTrackTask(index);
//
//         print('Task with ID: $taskId has already been tracked for $trackedDate.');
//       }
//     } catch (e) {
//       print("Error toggling task selection: $e");
//     }
//   }
//
//   void addTaskForDate(DateTime date, int taskIndex) {
//     final dateKey = DateFormat('dd-MM-yyyy').format(date);
//     if (taskDateMapping.containsKey(dateKey)) {
//       taskDateMapping[dateKey]?.add(taskIndex);
//     } else {
//       taskDateMapping[dateKey] = [taskIndex];
//     }
//   }
//
//   Future<List<double>> fetchProgressDataForDateRange(
//       DateTime startDate, DateTime endDate, int taskId) async {
//     try {
//       List<double> weeklyProgress = [];
//       DateTime currentDate = startDate;
//
//       while (currentDate.isBefore(endDate.add(Duration(days: 1)))) {
//         double progressForDate = await fetchProgressForDate(currentDate, taskId);
//
//         String trackedDate = DateFormat('yyyy-MM-dd').format(currentDate);
//         completionDates[trackedDate] = progressForDate == 1.0;
//
//         weeklyProgress.add(progressForDate);
//         currentDate = currentDate.add(Duration(days: 1));
//       }
//
//       return weeklyProgress;
//     } catch (e) {
//       print("Error fetching progress data: $e");
//       return List<double>.filled(
//           7, 0.0); // Return default data in case of error
//     }
//   }
//
//   Future<double> fetchProgressForDate(DateTime date, int taskId) async {
//     String trackedDate = DateFormat('dd-MM-yyyy').format(date);
//     print("task $taskId is tracked for date: $trackedDate");
//     bool isTracked =
//         await _databaseHelper.isTaskTrackedForDate(taskId, trackedDate);
//     print("Task $taskId tracked on $trackedDate: $isTracked");
//
//     return isTracked ? 4.0 : 0.0;
//   }
//
//   void pinTask(int index) async{
//     final prefs = await SharedPreferences.getInstance();
//     final task = taskList[index];
//
//     if (pinnedTasks.contains(task)) {
//       pinnedTasks.remove(task);
//       print('Task unpinned: $task');
//     } else {
//       if (pinnedTasks.length >= 2) {
//         final taskToUnpin = pinnedTasks.removeAt(0);
//         print('Automatically unpinned task: $taskToUnpin');
//       }
//
//       pinnedTasks.add(task);
//       print('Task pinned: $task');
//
//       taskList.removeAt(index);
//       taskList.insert(0, task);
//     }
//     await prefs.setStringList('pinnedTasks', pinnedTasks.toList());
//     print('Pinned tasks saved: ${pinnedTasks.toList()}');
//     update();
//   }
// }
//
//

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/dbhelper.dart';

import 'package:intl/intl.dart';

class TaskController extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  var taskList = <String>[].obs;
  var isTaskSelected = <bool>[].obs;
  List<double> progressData = List<double>.filled(7, 0.0);
  var completionDates = <String, bool>{}.obs;
  var taskDateMapping = <String, List<int>>{}.obs;
  var taskIdList = <int>[].obs;
  var pinnedTasks = <String>[].obs;
  var taskUnit = <int>[].obs;
  var isPlaying = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
    // loadPinnedTasks();
  }

  Future<List<bool>> loadTasks() async {
    List<bool> taskStatusList = [];
    try {
      final tasks = await _databaseHelper.getTasks();
      print('Tasks retrieved: $tasks');
      taskList.value = tasks
          .map((task) => task[DatabaseHelper.columnTask] as String)
          .toList();
      taskIdList.value =
          tasks.map((task) => task[DatabaseHelper.columnId] as int).toList();
      taskUnit.value = tasks
          .map((task) => task[DatabaseHelper.columnUnitId] as int)
          .toList(); // Load unit IDs

      isTaskSelected.value = List<bool>.filled(taskList.length, false);

      String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

      // taskIdList.asMap().entries.forEach((MapEntry<int, int> entry) async {
      //   bool isTracked = await _databaseHelper.isTaskTrackedForDate(entry.value, trackedDate);
      //   isTaskSelected[entry.key] = isTracked;
      // });

      for (var i = 0; i < taskIdList.length; i++) {
        bool isTracked = await _databaseHelper.isTaskTrackedForDate(
            taskIdList[i], trackedDate);
        isTaskSelected[i] = isTracked;
        taskStatusList.add(isTracked);
      }
      await loadPinnedTasks();

      print('Loaded Tasks: ${taskList.value}');
      print('Is Task Selected: ${isTaskSelected.value}');
      print('Task Status List : $taskStatusList');
      return taskStatusList;
    } catch (e) {
      print("Error loading tasks: $e");
      return [];
    }
  }

  Future<void> loadPinnedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedPinnedTasks = prefs.getStringList('pinnedTasks');

    if (savedPinnedTasks != null && savedPinnedTasks.isNotEmpty) {
      pinnedTasks.value = savedPinnedTasks;

      for (var task in pinnedTasks) {
        if (taskList.contains(task)) {
          taskList.remove(task);
          taskList.insert(0, task);
        }
      }
      print('Pinned tasks re-ordered: $savedPinnedTasks');
    }
  }

  Future<int> addTask(String task, int unitId, int target) async {
    try {
      int result = await _databaseHelper.insertTask(task, unitId, target);
      loadTasks();
      return result;
    } catch (e) {
      print("Error adding task: $e");
      return -1;
    }
  }

  Future<void> toggleTaskStatus(int id) async {
    print("toggleTaskStatus called with id: $id");

    try {
      final db = await DatabaseHelper().database;
      print("Database accessed succfully");

      int updateId = await db.insert(
        DatabaseHelper.tableTaskTrack,
        {
          DatabaseHelper.columnTaskId: id,
          DatabaseHelper.columnTrackedDate:
              DateFormat('dd-MM-yyyy').format(DateTime.now()),
        },
      );

      print(
          "Inserted task tracking with update_id: $updateId for task_id: $id.");
    } catch (e) {
      print("Error tracking task status for task $id: $e");
    }
  }

  void deleteTrackTask(int index) async {
    try {
      int taskId = taskIdList[index];
      String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

      await _databaseHelper.deleteTrackTask(taskId, trackedDate);
      //isTaskSelected[index] = false;

      //taskList.removeAt(index);

      //isTaskSelected.removeAt(index);
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  void deleteTrackTaskByTaskId(int taskId) async {
    try {
      await _databaseHelper.deleteTrackTask(taskId, null);
      //isTaskSelected[index] = false;

      //isTaskSelected.removeAt(index);
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  void deleteTask(int index) async {
    try {
      int taskId = taskIdList[index];

      await _databaseHelper.deleteTask(taskId);
      taskList.removeAt(index);
      deleteTrackTaskByTaskId(taskId);
      //isTaskSelected.removeAt(index);
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  // Future<void> toggleTaskSelection(int index, bool value) async {
  //   try {
  //     if (index < 0 || index >= taskList.length) {
  //       throw ArgumentError("Index out of range");
  //     }
  //
  //     String taskToUpdate = taskList[index];
  //
  //     double progress = value ? 1.0 : 0.0;
  //     String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //     int taskId = taskIdList[index];
  //
  //     isTaskSelected[index] = value;
  //
  //     if (value == true) {
  //       await _databaseHelper.insertTrackTask(taskId);
  //       print('Task with ID: $taskId has already been tracked for $trackedDate.');
  //     } else {
  //       deleteTrackTask(index);
  //
  //       print('Task with ID: $taskId has already been tracked for $trackedDate.');
  //     }
  //   } catch (e) {
  //     print("Error toggling task selection: $e");
  //   }
  // }
  Future<void> toggleTaskSelection(
      int index, bool value, DateTime? startTime, DateTime? endTime) async {
    try {
      if (index < 0 || index >= taskList.length) {
        throw ArgumentError("Index out of range");
      }

      String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      int taskId = taskIdList[index];

      isTaskSelected[index] = value;

      if (value) {
        if (startTime != null && endTime != null) {
          await _databaseHelper.insertTrackTask(taskId: taskId, startTime: startTime, endTime: endTime);
          print('Task with ID: $taskId has been tracked for $trackedDate from $startTime to $endTime.');
        } else {
          print('Task with ID: $taskId is selected, but not tracked as it is not a time unit.');
        }
      } else {
        await _databaseHelper.deleteTrackTask(taskId, trackedDate);
        print('Tracking removed for task ID: $taskId for date: $trackedDate.');
      }
    } catch (e) {
      print("Error toggling task selection: $e");
    }
  }

  void addTaskForDate(DateTime date, int taskIndex) {
    final dateKey = DateFormat('dd-MM-yyyy').format(date);
    if (taskDateMapping.containsKey(dateKey)) {
      taskDateMapping[dateKey]?.add(taskIndex);
    } else {
      taskDateMapping[dateKey] = [taskIndex];
    }
  }

  Future<List<double>> fetchProgressDataForDateRange(
      DateTime startDate, DateTime endDate, int taskId) async {
    try {
      List<double> weeklyProgress = [];
      DateTime currentDate = startDate;

      while (currentDate.isBefore(endDate.add(Duration(days: 1)))) {
        double progressForDate =
            await fetchProgressForDate(currentDate, taskId);

        String trackedDate = DateFormat('yyyy-MM-dd').format(currentDate);
        completionDates[trackedDate] = progressForDate == 1.0;

        weeklyProgress.add(progressForDate);
        currentDate = currentDate.add(Duration(days: 1));
      }

      return weeklyProgress;
    } catch (e) {
      print("Error fetching progress data: $e");
      return List<double>.filled(7, 0.0);
    }
  }

  Future<double> fetchProgressForDate(DateTime date, int taskId) async {
    String trackedDate = DateFormat('dd-MM-yyyy').format(date);
    print("task $taskId is tracked for date: $trackedDate");
    bool isTracked =
        await _databaseHelper.isTaskTrackedForDate(taskId, trackedDate);
    print("Task $taskId tracked on $trackedDate: $isTracked");

    return isTracked ? 1.0 : 0.0;
  }

  void pinTask(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final task = taskList[index];

    if (pinnedTasks.contains(task)) {
      pinnedTasks.remove(task);
      print('Task unpinned: $task');
      taskList.removeAt(0);
      int originalIndex = taskList.indexOf(task);

      if (originalIndex >= 0) {
        taskList.insert(originalIndex, task);
      } else {
        taskList.add(task);
      }
    } else {
      if (pinnedTasks.length >= 2) {
        final taskToUnpin = pinnedTasks.removeAt(0);
        print('Automatically unpinned task: $taskToUnpin');
      }

      pinnedTasks.add(task);
      print('Task pinned: $task');

      taskList.removeAt(index);
      taskList.insert(0, task);
    }

    await prefs.setStringList('pinnedTasks', pinnedTasks.toList());
    print('Pinned tasks saved: ${pinnedTasks.toList()}');
    update();
  }

  Future<void> addUnitToTask(int task, String unit) async {
    try {
      print('Unit "$unit" added to task with ID $task successfully');
      loadTasks();
    } catch (e) {
      print("Error adding unit to task: $e");
    }
  }

  Future<Map<String, dynamic>?> getTargetValue(int taskId) async {
    return await _databaseHelper.getTargetValue(taskId);
  }

  Future<double> getProgressForDate(int taskId, DateTime date) async {
    String trackedDate = DateFormat('dd-MM-yyyy').format(date);
    bool isTracked =
        await _databaseHelper.isTaskTrackedForDate(taskId, trackedDate);

    return isTracked ? 1.0 : 0.0;
  }

  // void togglePlayPause(int index) async {
  //   try {
  //     if (index < 0 || index >= taskList.length) {
  //       throw ArgumentError("Index out of range");
  //     }
  //
  //     String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //     int taskId = taskIdList[index];
  //
  //     // Initialize isPlaying[index] to false if it's null
  //     isPlaying[index] ??= false;
  //
  //     // Toggle the isPlaying state safely
  //     isPlaying[index] = !isPlaying[index]!;
  //
  //     update();
  //
  //     // If the task is now in a "playing" state (selected or activated)
  //     if (isPlaying[index]!) {
  //       isTaskSelected[index] = true;
  //
  //       DateTime startTime = DateTime.now(); // Capture the start time
  //       await _databaseHelper.insertTrackTask(taskId: taskId, startTime: startTime);
  //       print('Task with ID: $taskId has been tracked for $trackedDate.');
  //     } else {
  //       isTaskSelected[index] = false;
  //
  //       await _databaseHelper.deleteTrackTask(taskId, trackedDate);
  //       print('Tracking removed for task ID: $taskId for date: $trackedDate.');
  //     }
  //   } catch (e) {
  //     print("Error toggling task selection: $e");
  //   }
  // }

  Future<List<Map<String, dynamic>>> getTimeLapseForTask(int taskId) async {
    return await _databaseHelper.getTimeLapseForTask(taskId);
  }
}
