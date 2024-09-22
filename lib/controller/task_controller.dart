import 'package:get/get.dart';
import '../database/dbhelper.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../database/dbhelper.dart';

class TaskController extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  var taskList = <String>[].obs;
  var isTaskSelected = <bool>[].obs;
  // List<double> progressData = List<double>.filled(7, 0.0);
  var completionDates = <String, bool>{}.obs;
  var taskDateMapping = <String, List<int>>{}.obs;
  var taskIdList = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }





  Future<List<bool>> loadTasks() async {
    List<bool> taskStatusList = [];
    try {
      // Tasks ko load karo
      final tasks = await _databaseHelper.getTasks();
      print('Tasks retrieved: $tasks');
      taskList.value = tasks.map((task) => task[DatabaseHelper.columnTask] as String).toList();
      taskIdList.value = tasks.map((task) => task[DatabaseHelper.columnId] as int).toList();
      isTaskSelected.value = List<bool>.filled(taskList.length, false);
      String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      taskIdList.asMap().entries.forEach((MapEntry<int, int> entry) async {
        bool isTracked = await _databaseHelper.isTaskTrackedForDate(entry.value, trackedDate);
        isTaskSelected[entry.key] = isTracked;
      });
      for (var i = 0; i < taskIdList.length; i++) {
        bool isTracked = await _databaseHelper.isTaskTrackedForDate(taskIdList[i], trackedDate);
        isTaskSelected[i] = isTracked;
        taskStatusList.add(isTracked);
      }
      print('Loaded Tasks: ${taskList.value}');
      print('Is Task Selected: ${isTaskSelected.value}');
      print('Task Status List : $taskStatusList');
      return taskStatusList;
    } catch (e) {
      print("Error loading tasks: $e");
      return [];
    }
  }


  // void loadTasks() async {
  //   try {
  //     final tasks = await _databaseHelper.getTasks();
  //     print('Tasks retrieved: $tasks');
  //
  //     taskList.value = tasks.map((task) => task[DatabaseHelper.columnTask] as String).toList();
  //     taskIdList.value = tasks.map((task) => task[DatabaseHelper.columnId] as int).toList();
  //
  //     isTaskSelected.value = List<bool>.filled(taskList.length, false);
  //
  //     // isTaskSelected.value = tasks.map((task) {
  //     //   bool isTracked = await _databaseHelper.isTaskTrackedForDate(taskId,trackedDate);
  //     //
  //     //
  //     //   //final isChecked = task[DatabaseHelper.columnIsChecked];
  //     //   return (isChecked != null && (isChecked as int) == 1);
  //     // }).toList();
  //
  //     // Update completionDates
  //     completionDates.clear();
  //     String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //
  //     taskIdList.asMap().entries.forEach((MapEntry<int, int> entry) async {
  //       bool isTracked = await _databaseHelper.isTaskTrackedForDate(entry.value, trackedDate);
  //       isTaskSelected[entry.key] = isTracked;
  //     });
  //
  //     //   for (var task in tasks) {
  //     //     final taskDateStr = task[DatabaseHelper.columnTrackedDate] as String?;
  //     //   //  final isChecked = task[DatabaseHelper.columnIsChecked] as int?;
  //     //
  //     //   //   if (taskDateStr != null && isChecked != null) {
  //     //   //     try {
  //     //   //       final taskDate = DateTime.parse(taskDateStr);
  //     //   //       final dateKey = DateFormat('yyyy-MM-dd').format(taskDate);
  //     //   //       completionDates[dateKey] = isChecked == 1;
  //     //   //     } catch (e) {
  //     //   //       print("Error parsing date: $taskDateStr - $e");
  //     //   //     }
  //     //   //   } else {
  //     //   //     print("Missing data: taskDateStr: $taskDateStr, isChecked: $isChecked");
  //     //   //   }
  //     //   // }
  //     //
  //     //   print('Loaded Tasks: ${taskList.value}');
  //     //   print('Is Task Selected: ${isTaskSelected.value}');
  //     //   print('Completion Dates: ${completionDates}'); // Debug print
  //     //
  //     //   update(); // Notify listeners
  //     //
  //   } catch (e) {
  //     // print("Error loading tasks: $e");
  //   }
  // }

  Future<void> addTask(String task) async {
    try {
      //  bool isChecked = false;
      // double progress = 0.0;
      //  String createdDate = DateTime.now().toIso8601String();
      //  String updatedDate = createdDate;
      //  String dayName = DateFormat('EEEE').format(DateTime.now()); // Get the day name

      int result = await _databaseHelper.insertTask(task);
      // if (result == -1) {
      //   print("Task already exists");
      // } else {
      //   await _databaseHelper.updateTaskDayName(task, dayName); // Add day name
      //   print("Task added successfully");
      //   loadTasks();
      // }
      loadTasks();
    } catch (e) {
      print("Error adding task: $e");
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
      isTaskSelected.removeAt(index);
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  void deleteTask(int index) async {
    try {
      int taskId = taskIdList[index];

      await _databaseHelper.deleteTask(taskId);
      taskList.removeAt(index);
      isTaskSelected.removeAt(index);
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  Future<void> toggleTaskSelection(int index, bool value) async {
    try {
      if (index < 0 || index >= taskList.length) {
        throw ArgumentError("Index out of range");
      }

      String taskToUpdate = taskList[index];
      double progress = value ? 1.0 : 0.0;
      String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      int taskId = taskIdList[index];

      // String updatedDate = DateTime.now().toIso8601String(); // Current date and time
      //String dayName = DateFormat('EEEE').format(DateTime.now()); // Current day name

      isTaskSelected[index] = value;
      // if(value == true){
      //   await _databaseHelper.insertTrackTask(taskId);
      // }
      // else{
      //
      // }

      if (value == true) {
        await _databaseHelper.insertTrackTask(taskId);
        print(
            'Task with ID: $taskId has already been tracked for $trackedDate.');
      } else {
        deleteTrackTask(index);

        print(
            'Task with ID: $taskId has already been tracked for $trackedDate.');
      }

      // Update task with the new values
      // await _databaseHelper.updateTask(taskToUpdate, taskToUpdate, value, progress, updatedDate);
      // Update the day name for the task
      //await _databaseHelper.updateTaskDayName(taskToUpdate, dayName);
      //await recalculateProgressForLastDays(7); // Example for 7 days, can be adjusted
    } catch (e) {
      print("Error toggling task selection: $e");
    }
  }

  Future<List<double>> fetchProgressDataForTrackedDate(
      String trackedDate) async {List<double> progressData = List.filled(7, 0.0);

    for (int i = 0; i < 7; i++) {
      DateTime date =  DateFormat('dd-MM-yyyy').parse(trackedDate).subtract(Duration(days: i));
      String dateString = DateFormat('dd-MM-yyyy').format(date);

      bool isTaskCompleted = completionDates[dateString] ?? false;
      progressData[i] = isTaskCompleted ? 1.0 : 0.0;
    }
    return progressData;
  }
  Future<void> updateTaskStatus(int index, bool isTracked) async {
    try {
      if (index < 0 || index >= taskList.length) {
        throw ArgumentError("Index out of range");
      }
      String taskToUpdate = taskList[index];
      double progress = isTracked ? 1 : 0;
      String trackedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      // double progress = isCompleted ? 1.0 : 0.0;
      // String updatedDate = DateTime.now().toIso8601String();
      // String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      // String dayName = DateFormat('EEEE').format(DateTime.now());

      // Do not change the checkbox state; only update task status in the database
      // await _databaseHelper.updateTask(taskToUpdate, taskToUpdate, isCompleted, progress, updatedDate);
      // await _databaseHelper.insertTaskUpdate(taskToUpdate, isCompleted, progress, updatedDate);

      // if (!isCompleted) {
      //   print("Task '$taskToUpdate' marked as not completed, but checkbox remains unaffected.");
      // }

      // Fetch the task details
      List<Map<String, dynamic>> taskData = await _databaseHelper.getTasks();
      Map<String, dynamic>? task = taskData.firstWhere(
          (task) => task[DatabaseHelper.columnTask] == taskToUpdate,
          orElse: () => <String, dynamic>{});
      //   if (task.isNotEmpty) {
      //    // String taskCreationDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(task[DatabaseHelper.columnCreatedDate]));String taskDayName = task[DatabaseHelper.columnDayName] as String? ?? "Unknown";
      //
      //     if (taskCreationDate == todayDate) {
      //       print(
      //           "Task '${taskToUpdate}' marked as ${isCompleted ? 'completed' : 'not completed'} for today: $todayDate (Day: $dayName).");
      //     } else {
      //       print(
      //           "Task '${taskToUpdate}' was created on $taskCreationDate (Day: $taskDayName) and marked as ${isCompleted ? 'completed' : 'not completed'} for today: $todayDate (Day: $dayName).");
      //     }
      //   } else {
      //     print("Task '${taskToUpdate}' not found in database.");
      //   }
    } catch (e) {
      print("Error updating task status: $e");
    }
  }

  Future<void> updateTaskStatusByIndex(int index, bool isCompleted) async {
    try {
      if (index < 0 || index >= taskList.length) {
        throw ArgumentError("Index out of range");
      }

      await updateTaskStatus(index, isCompleted);
    } catch (e) {
      print("Error updating task status by index: $e");
    }
  }

  // Future<List<double>> fetchProgressDataForLastDays(int days) async {
  //   try {
  //     final today = DateTime.now();
  //     final startDate = today.subtract(Duration(days: today.weekday - 1)); // Monday of the current week
  //     final endDate = startDate.add(Duration(days: days - 1)); // End of the range
  //
  //     final tasks = await _databaseHelper.getTasks(); // Fetch tasks from the database
  //     List<double> progressData = List<double>.filled(days, 0.0); // Initialize progress data with zeros
  //
  //     await Future.forEach(tasks, (task) async {
  //       final taskCompletionDate = task['updated_date']; // Fetch the updated date (completion date)
  //       final isChecked = task['is_checked']; // Fetch task status (isChecked)
  //
  //       if (taskCompletionDate != null) {
  //         final taskDate = DateTime.parse(taskCompletionDate).toLocal();
  //         int dayIndex = taskDate.difference(startDate).inDays;
  //
  //         if (isChecked == 1) {
  //           // Ensure the task date is within the range of the last 'days' days
  //           if (taskDate.isAfter(startDate.subtract(Duration(days: 1))) &&
  //               taskDate.isBefore(endDate)) {
  //             if (dayIndex >= 0 && dayIndex < days) {
  //               progressData[dayIndex] += 1.0; // Add task progress for that day
  //             }
  //           }
  //         }
  //       }
  //     });
  //
  //     // Special handling for today's tasks
  //     final todayIndex = today.weekday - 1; // Index for today's day
  //     final todayDate = DateTime(today.year, today.month, today.day);
  //
  //     await Future.forEach(tasks, (task) async {
  //       final taskCompletionDate = task['updated_date'];
  //       final isChecked = task['is_checked'];
  //
  //       if (taskCompletionDate != null && isChecked == 1) {
  //         final taskDate = DateTime.parse(taskCompletionDate).toLocal();
  //         if (taskDate.year == todayDate.year &&
  //             taskDate.month == todayDate.month &&
  //             taskDate.day == todayDate.day) {
  //           if (todayIndex >= 0 && todayIndex < days) {
  //             progressData[todayIndex] += 1.0;
  //           }
  //         }
  //       }
  //     });
  //
  //     print('Filtered Progress Data: $progressData');
  //     print('Start Date: $startDate, End Date: $endDate');
  //
  //     return progressData;
  //   } catch (e) {
  //     print("Error fetching progress data: $e");
  //     return List<double>.filled(days, 0.0); // Return zeros if there’s an error
  //   }
  // }

  // Future<void> recalculateProgressForLastDays(int days) async {
  //   try {
  //     final progressData = await fetchProgressDataForLastDays(days);
  //     print("Progress for the last $days days: $progressData");
  //   } catch (e) {
  //     print("Error recalculating progress: $e");
  //   }
  // }

  // void markTaskCompleted(DateTime date) {
  //   final dateKey = DateFormat('yyyy-MM-dd').format(date);
  //   completionDates[dateKey] = true;
  //   print('Task marked as completed for today: $dateKey.');
  // }

  void addTaskForDate(DateTime date, int taskIndex) {
    final dateKey = DateFormat('dd-MM-yyyy').format(date);
    if (taskDateMapping.containsKey(dateKey)) {
      taskDateMapping[dateKey]?.add(taskIndex);
    } else {
      taskDateMapping[dateKey] = [taskIndex];
    }
  }

  // List<int> getTasksForDate(DateTime date) {
  //   final dateKey = DateFormat('yyyy-MM-dd').format(date);
  //   return taskDateMapping[dateKey] ?? [];
  // }
}
