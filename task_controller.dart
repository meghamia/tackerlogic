import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../database/dbhelper.dart';

class TaskController extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  var taskList = <String>[].obs;
  var isTaskSelected = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    try {
      final tasks = await _databaseHelper.getTasks();
      taskList.value = tasks.map((task) => task[DatabaseHelper.columnTask] as String).toList();
      isTaskSelected.value = tasks.map((task) {
        final isChecked = task[DatabaseHelper.columnIsChecked];
        return (isChecked != null && (isChecked as int) == 1);
      }).toList();
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }

  Future<void> addTask(String task) async {
    try {
      bool isChecked = false;
      double progress = 0.0;
      String createdDate = DateTime.now().toIso8601String();
      String updatedDate = createdDate;
      String dayName = DateFormat('EEEE').format(DateTime.now()); // Get the day name

      int result = await _databaseHelper.insertTask(
          task, isChecked, progress, createdDate, updatedDate);
      if (result == -1) {
        print("Task already exists");
      } else {
        await _databaseHelper.updateTaskDayName(task, dayName); // Add day name
        print("Task added successfully");
        loadTasks();
      }
    } catch (e) {
      print("Error adding task: $e");
    }
  }

  void deleteTask(int index) async {
    try {
      String taskToDelete = taskList[index];
      await _databaseHelper.deleteTask(taskToDelete);
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
      String updatedDate = DateTime.now().toIso8601String(); // Current date and time
      String dayName = DateFormat('EEEE').format(DateTime.now()); // Current day name

      isTaskSelected[index] = value;

      // Update task with the new values
      await _databaseHelper.updateTask(
          taskToUpdate, taskToUpdate, value, progress, updatedDate);
      // Update the day name for the task
      await _databaseHelper.updateTaskDayName(taskToUpdate, dayName);
      await recalculateProgressForLastDays(7); // Example for 7 days, can be adjusted

    } catch (e) {
      print("Error toggling task selection: $e");
    }
  }



  Future<void> updateTaskStatus(int index, bool isCompleted) async {
    try {
      if (index < 0 || index >= taskList.length) {
        throw ArgumentError("Index out of range");
      }

      String taskToUpdate = taskList[index];
      double progress = isCompleted ? 1.0 : 0.0;
      String updatedDate = DateTime.now().toIso8601String();
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String dayName = DateFormat('EEEE').format(DateTime.now());

      // Do not change the checkbox state; only update task status in the database
      await _databaseHelper.updateTask(
          taskToUpdate, taskToUpdate, isCompleted, progress, updatedDate);
      await _databaseHelper.insertTaskUpdate(
          taskToUpdate, isCompleted, progress, updatedDate);

      // If the task is not completed, just update it, but don't touch the checkbox
      if (!isCompleted) {
        print("Task '$taskToUpdate' marked as not completed, but checkbox remains unaffected.");
      }

      // Fetch the task details
      List<Map<String, dynamic>> taskData = await _databaseHelper.getTasks();
      Map<String, dynamic>? task = taskData.firstWhere(
              (task) => task[DatabaseHelper.columnTask] == taskToUpdate,
          orElse: () => <String, dynamic>{});

      if (task.isNotEmpty) {
        String taskCreationDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(task[DatabaseHelper.columnCreatedDate]));
        String taskDayName = task[DatabaseHelper.columnDayName] as String? ?? "Unknown";

        if (taskCreationDate == todayDate) {
          print("Task '${taskToUpdate}' marked as ${isCompleted ? 'completed' : 'not completed'} for today: $todayDate (Day: $dayName).");
        } else {
          print("Task '${taskToUpdate}' was created on $taskCreationDate (Day: $taskDayName) and marked as ${isCompleted ? 'completed' : 'not completed'} for today: $todayDate (Day: $dayName).");
        }
      } else {
        print("Task '${taskToUpdate}' not found in database.");
      }
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
  //
  //     final tasks = await _databaseHelper.getTasks(); // Fetch tasks from the database
  //     List<double> progressData = List<double>.filled(days, 0.0); // Initialize progress data with zeros
  //
  //     for (var task in tasks) {
  //       final taskCompletionDate = task['updated_date']; // Fetch the updated date (completion date)
  //       final isChecked = task['is_checked']; // Fetch task status (isChecked)
  //
  //       if (taskCompletionDate != null) {
  //         final taskDate = DateTime.parse(taskCompletionDate);
  //
  //         // Only consider tasks that fall within the specified date range
  //         if (taskDate.isAfter(startDate.subtract(Duration(days: 1))) && taskDate.isBefore(startDate.add(Duration(days: days)))) {
  //           // Calculate the day index (Monday=0, ..., Sunday=6)
  //           int dayIndex = (taskDate.difference(startDate).inDays % days + days) % days;
  //
  //           // If the task is completed (isChecked == 1), increase progress
  //           if (isChecked == 1) {
  //             progressData[dayIndex] += 1.0; // Add task progress for that day
  //           }
  //         }
  //       }
  //
  //       // Additional check to mark today's progress
  //       final todayIndex = today.weekday - 1; // Get index for today (Monday=0, ..., Sunday=6)
  //       if (isChecked == 1 && DateTime.parse(taskCompletionDate).toLocal().toIso8601String().split('T').first == today.toLocal().toIso8601String().split('T').first) {
  //         progressData[todayIndex] += 1.0; // Add progress for today if the task is completed
  //       }
  //     }
  //
  //     return progressData; // Return the progress data list
  //   } catch (e) {
  //     print("Error fetching progress data: $e");
  //     return List<double>.filled(days, 0.0); // Return zeros if there’s an error
  //   }
  // }

  Future<List<double>> fetchProgressDataForLastDays(int days) async {
    try {
      final today = DateTime.now();
      final startDate = today.subtract(Duration(days: today.weekday - 1)); // Monday of the current week
      final endDate = startDate.add(Duration(days: days)); // End of the range

      final tasks = await _databaseHelper.getTasks(); // Fetch tasks from the database
      List<double> progressData = List<double>.filled(days, 0.0); // Initialize progress data with zeros

      for (var task in tasks) {
        final taskCompletionDate = task['updated_date']; // Fetch the updated date (completion date)
        final isChecked = task['is_checked']; // Fetch task status (isChecked)

        if (taskCompletionDate != null) {
          final taskDate = DateTime.parse(taskCompletionDate).toLocal();
          int dayIndex = taskDate.difference(startDate).inDays;

          if (isChecked == 1) {
            // Ensure the task date is within the range of the last 'days' days
            if (taskDate.isAfter(startDate.subtract(Duration(days: 1))) && taskDate.isBefore(endDate)) {
              if (dayIndex >= 0 && dayIndex < days) {
                progressData[dayIndex] += 1.0; // Add task progress for that day
              }
            }
          }
        }
      }

      // Special handling for today's tasks (which might be missed)
      final todayIndex = today.weekday - 1; // Index for today's day
      final todayDate = DateTime(today.year, today.month, today.day);

      for (var task in tasks) {
        final taskCompletionDate = task['updated_date']; // Fetch the updated date (completion date)
        final isChecked = task['is_checked']; // Fetch task status (isChecked)

        if (taskCompletionDate != null && isChecked == 1) {
          final taskDate = DateTime.parse(taskCompletionDate).toLocal();
          if (taskDate.year == todayDate.year && taskDate.month == todayDate.month && taskDate.day == todayDate.day) {
            if (todayIndex >= 0 && todayIndex < days) {
              progressData[todayIndex] += 1.0; // Add today's task progress
            }
          }
        }
      }

      // Debug print statements to verify filtering and calculations
      print('Filtered Progress Data: $progressData');
      print('Start Date: $startDate, End Date: $endDate'); // Print the start and end date for verification

      return progressData; // Return the progress data list

    } catch (e) {
      print("Error fetching progress data: $e");
      return List<double>.filled(days, 0.0); // Return zeros if there’s an error
    }
  }




  Future<void> recalculateProgressForLastDays(int days) async {
    try {
      final progressData = await fetchProgressDataForLastDays(days);
      print("Progress for the last $days days: $progressData");
    } catch (e) {
      print("Error recalculating progress: $e");
    }
  }



}


