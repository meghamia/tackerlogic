import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; // Import Neumorphic package
import 'package:get/get.dart';
import 'package:goalsync/controller/task_controller.dart';
import 'package:goalsync/screens/task_screen.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:goalsync/service/drawer.dart';
import 'package:intl/intl.dart';

import '../controller/theme_controller.dart';

class HabitScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Scaffold(
      key: drawerKey,
      appBar: _appBar(context),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Row(
              children: [], // Add your widgets here if needed
            ),
          ),
          Expanded(
            child: Obx(() {
              if (taskController.isTaskSelected.length <
                  taskController.taskList.length) {
                taskController.isTaskSelected.addAll(
                  List.generate(
                    taskController.taskList.length -
                        taskController.isTaskSelected.length,
                    (_) => false,
                  ),
                );
              }

              return ListView.separated(
                itemCount: taskController.taskList.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(taskController.taskList[index]),
                    background: Container(
                      color: Colors.blue.shade300,
                      child: Icon(Icons.delete_outline,
                          size: 35, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      taskController.deleteTask(index);
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 50,
                        child: Row(

                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(TaskScreen(
                                    taskName: taskController.taskList[index],
                                    isTaskChecked: true,
                                    index: index,
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(14.0),
                                  constraints: BoxConstraints(
                                      //maxWidth: 267
                                      maxWidth: MediaQuery.of(context).size.width * 0.85,
                                      ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/corner (1).png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    // Added Padding here
                                    padding: EdgeInsets.only(
                                        left: 10.0), // Shift text to the right
                                    child: Text(
                                      taskController.taskList[index],
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Change color for better contrast
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 1),
                            GestureDetector(
                              onTap: () {
                                taskController.toggleTaskSelection(
                                  index,
                                  !taskController.isTaskSelected[index],
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img.png'), // Checkbox image
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (taskController.isTaskSelected[index])
                                    Container(
                                      width: 15, // Size for the tick image
                                      height: 15,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/img_1.png'), // Tick image
                                          fit: BoxFit
                                              .contain, // Ensure the tick fits inside the container
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Neumorphic(
        style: neumorphicButtonStyle(context, isSelected: false),
        child: AppBar(
          title: Text("My Habits"),
          centerTitle: true,
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // Remove default AppBar shadow
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: isDarkTheme
                  ? Colors.white
                  : Colors.black, // Ensure visibility
            ),
            onPressed: () {
              drawerKey.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                _showAddTaskBottomSheet();
              },
              icon: Icon(
                Icons.add,
                color:
                    Theme.of(context).iconTheme.color, // Use theme icon color
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet() {
    final TaskController taskController = Get.find();
    final TextEditingController taskControllerInput = TextEditingController();

    Get.bottomSheet(
      Container(
        height: 300,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF2E2E2E), // Set the background color of the bottom sheet
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)), // Set the top corners to be rounded
        ),
        child: Column(
          children: [
            Text(
              'Add New Task',
              style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Colors.white), // Adjusted text color for dark theme
            ),
            SizedBox(height: 20),
            Neumorphic(
              style: neumorphicBottomSheetStyle(Get.context!),
              child: TextField(
                controller: taskControllerInput,
                decoration: InputDecoration(
                  hintText: 'Enter task',
                  hintStyle: TextStyle(color: Colors.white70), // Adjusted hint text color
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                style: TextStyle(color: Colors.white), // Adjusted input text color
                autofocus: true,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 160, // Adjust width for Save button
              child: NeumorphicButton(
                style: neumorphicButtonStyle(Get.context!, isSelected: false),
                onPressed: () {
                  final task = taskControllerInput.text.trim();
                  if (task.isNotEmpty) {
                    taskController.addTask(task);

                    // Call addTaskForDate
                    final taskIndex = taskController.taskList.length - 1;
                    taskController.addTaskForDate(DateTime.now(), taskIndex);
                  }
                  Get.back(); // Close the bottom sheet
                },
                child: Center(
                  child: Text(
                    'Save',
                    style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(color: Colors.white), // Adjusted text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent, // Keep background transparent for effect
    );
  }
}
