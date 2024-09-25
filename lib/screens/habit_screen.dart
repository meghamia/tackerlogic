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
  final TextEditingController taskControllerInput = TextEditingController();

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
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 60,
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
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.85,

                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? Color(0xFFF5F5FA) // Light theme background color
                                        : Color(0xFF2E2E2E), // Dark theme background color
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).brightness == Brightness.light ? Color(0xFFE0E0E0) // Light shadow for depth in light theme
                                            : Color(0xFF1E1E1E), // Dark shadow for depth in dark theme
                                        offset: Offset(6, 6), blurRadius: 12,
                                      ),
                                      BoxShadow(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? Color(0xFFFFFFFF).withOpacity(
                                                0.4) // Light shadow for an embedded effect in light theme
                                            : Color(
                                                0xFF3E3E3E), // Light shadow for an embedded effect in dark theme
                                        offset: Offset(-6, -6),
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0), // Shift text to the right
                                    child: Text(
                                      taskController.taskList[index],
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors
                                                .black // Text color is black in light theme
                                            : Colors
                                                .white, // Text color is white in dark theme
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
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
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Color(
                                              0xFFF5F5FA) // Light theme background color
                                          : Color(
                                              0xFF3E3E3E), // Dark theme background color
                                      borderRadius: BorderRadius.circular(
                                          8), // Ensure this matches your neumorphic style's border radius
                                      boxShadow: getCurrentThemeBoxShadows(
                                          context), // Use the dynamic box shadows based on the theme
                                    ),
                                    child: Neumorphic(
                                      style: checkBoxStyle(context,
                                          isSelected: taskController
                                              .isTaskSelected[index]),
                                      child: SizedBox(
                                        width:
                                            35, // Set width for the container
                                        height:
                                            35, // Set height for the container
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              taskController.isTaskSelected[index] ? Icons.check // Show tick icon when selected
                                                  : Icons.check_box_outline_blank,
                                              color: taskController.isTaskSelected[index] ? (Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white) // Tick color is white in dark theme
                                                  : Colors.transparent, // Empty checkbox remains transparent when not selected
                                            ),

                                            iconSize:
                                                20, // Adjust the size of the tick icon
                                            onPressed: () {
                                              taskController
                                                  .toggleTaskSelection(
                                                      index,
                                                      !taskController
                                                              .isTaskSelected[
                                                          index]);
                                            },
                                          ),
                                        ),
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
                _showAddTaskBottomSheet(context);
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

  void _showAddTaskBottomSheet(BuildContext context) {
    final TaskController taskController = Get.find();
    final TextEditingController taskControllerInput = TextEditingController();

    Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        child: Container(
          height: 300,
          padding: EdgeInsets.all(16.0),
          color: Theme.of(context).brightness == Brightness.light
              ? Color(0xFFF5F5FA) // Example light theme color
              : Color(0xFF2E2E2E), // Dark theme background color
          child: Column(
            children: [
              Text(
                'Add New Task',
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black // Text color for light theme
                        : Colors.white, // Text color for dark theme
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 60),
              neumorphicTextFormField(Get.context!,
                  taskControllerInput), // Using your custom widget
              SizedBox(height: 60),
              SizedBox(
                width: 160,
                child: Neumorphic(
                  style: neumorphicButtonStyle(Get.context!,
                      isSelected: false), // Apply neumorphic style
                  child: ElevatedButton(
                    onPressed: () {
                      final task = taskControllerInput.text.trim();
                      if (task.isNotEmpty) {
                        taskController.addTask(task);
                        final taskIndex = taskController.taskList.length - 1;
                        taskController.addTaskForDate(
                            DateTime.now(), taskIndex);
                      }
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .transparent, // Make button background transparent
                      shadowColor:
                          Colors.transparent, // Disable default button shadows
                      disabledForegroundColor: Colors.transparent
                          .withOpacity(0.38), // Transparent disabled foreground
                      disabledBackgroundColor: Colors.transparent
                          .withOpacity(0.12), // Transparent disabled background
                    ),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black // Text color for light theme
                                  : Colors.white, // Text color for dark theme
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
