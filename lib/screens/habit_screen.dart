// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:goalsync/controller/task_controller.dart';
// import 'package:goalsync/screens/task_screen.dart';
//
// import '../controller/theme_controller.dart';
//
// class HabitScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final TaskController taskController = Get.find();
//     final ThemeController themeController = Get.find();
//
//     return Scaffold(
//       appBar: _appBar(context),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(17.0),
//             child: Row(
//               children: [],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (taskController.isTaskSelected.length <
//                   taskController.taskList.length) {
//                 taskController.isTaskSelected.addAll(
//                   List.generate(
//                     taskController.taskList.length -
//                         taskController.isTaskSelected.length,
//                     (_) => false,
//                   ),
//                 );
//               }
//
//               return ListView.separated(
//                 itemCount: taskController.taskList.length,
//                 separatorBuilder: (context, index) =>
//                     SizedBox(height: 16), // Space between items
//                 itemBuilder: (context, index) {
//                   return Dismissible(
//                     key: ValueKey(taskController.taskList[index]),
//                     background: Container(
//                       color: Colors.blue.shade300,
//                       child: Icon(Icons.delete_outline,
//                           size: 35, color: Colors.white),
//                       alignment: Alignment.centerRight,
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                     ),
//                     direction: DismissDirection.endToStart,
//                     onDismissed: (direction) {
//                       taskController.deleteTask(index);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         color: Theme.of(context)
//                             .listTileTheme
//                             .tileColor, // Use theme tile color
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.all(14.0),
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context)
//                                       .cardColor, // Use theme card color
//                                   borderRadius: BorderRadius.circular(6),
//                                   border: Border.all(
//                                       color: Theme.of(context).cardColor,
//                                       width: 2),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(
//                                           0.5), // Shadow color for better visibility
//                                       spreadRadius: 1,
//                                       blurRadius: 4,
//                                       offset: Offset(0, 10),
//                                     ),
//                                   ],
//                                 ),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Get.to(TaskScreen(
//                                       taskName: taskController.taskList[index],
//                                       isTaskChecked:
//                                           taskController.isTaskSelected[index],
//                                     ));
//                                   },
//                                   child: Text(
//                                     taskController.taskList[index],
//                                     style: TextStyle(
//                                       color: Theme.of(context)
//                                           .textTheme
//                                           .bodyLarge!
//                                           .color, // Use theme text color
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                                 width:
//                                     10), // Space between container and checkbox
//                             Checkbox(
//                               value: taskController.isTaskSelected[index],
//                               onChanged: (bool? value) {
//                                 if (value != null) {
//                                   taskController.toggleTaskSelection(
//                                       index, value);
//                                 }
//                               },
//                               activeColor: Colors.blue,
//                               checkColor: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _appBar(BuildContext context) {
//     final ThemeController themeController = Get.find();
//     return AppBar(
//       title: Text("My Habits"),
//       actions: [
//         TextButton(
//           onPressed: () {
//             _showAddTaskDialog();
//           },
//           child: Text(
//             '+ ',
//             style: TextStyle(
//               color: Theme.of(context).iconTheme.color, // Use theme icon color
//               fontSize: 35,
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             // Use GetX to change the theme reactively
//             themeController.changeTheme();
//           },
//           child: Obx(() {
//             return Icon(
//               themeController.isDark.value ? Icons.dark_mode : Icons.light_mode,
//               color: Theme.of(context).iconTheme.color, // Use theme icon color
//             );
//           }),
//         ),
//         SizedBox(width: 16), // Optional: add spacing between icons
//       ],
//     );
//   }
//
//   void _showAddTaskDialog() {
//     final TaskController taskController = Get.find();
//     final TextEditingController taskControllerInput = TextEditingController();
//
//     showDialog(
//       context: Get.context!,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add New Task'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: taskControllerInput,
//                 decoration: InputDecoration(hintText: 'Enter task'),
//                 autofocus: true,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 final task = taskControllerInput.text.trim();
//                 if (task.isNotEmpty) {
//                   taskController.addTask(task);
//                 }
//                 Get.back(); // Close the dialog
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.back(); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; // Import Neumorphic package
import 'package:get/get.dart';
import 'package:tracker/controller/task_controller.dart';
import 'package:tracker/screens/task_screen.dart';
import 'package:tracker/screens/theme.dart';

import '../controller/theme_controller.dart';
import '../service/drawer.dart';

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
                separatorBuilder: (context, index) =>
                    SizedBox(height: 16), // Space between items
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Neumorphic(
                              style: neumorphicButtonStyle(
                                context,
                                isSelected:
                                    taskController.isTaskSelected[index],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(TaskScreen(
                                    taskName: taskController.taskList[index],
                                    isTaskChecked:
                                        taskController.isTaskSelected[index],
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(14.0),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75, // Reduce width
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Theme.of(context).cardColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    taskController.taskList[index],
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color, // Use theme text color
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
                              child: Neumorphic(
                                  style: neumorphicButtonStyle(
                                    context,
                                    isSelected:
                                        taskController.isTaskSelected[index],
                                  ),
                                  child: Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Checkbox background color
                                        Icon(
                                          taskController.isTaskSelected[index]
                                              ? Icons.check_box : Icons.check_box_outline_blank, // Unchecked state icon
                                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Theme.of(context).cardColor, // Background color for checkbox in dark theme
                                          size: 24,
                                        ),
                                        // Tick color
                                        if (taskController
                                            .isTaskSelected[index])
                                          Icon(
                                            Icons.check, // Tick icon
                                            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white, // Tick color in dark theme
                                            size: 30,
                                          ),
                                      ],
                                    ),
                                  ))),
                        ],
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
        style: neumorphicButtonStyle(context, isSelected: false,),

        child: AppBar(
          title: Text("My Habits"),
          centerTitle: true,
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // Remove default AppBar shadow
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: isDarkTheme ? Colors.white : Colors.black, // Ensure visibility
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
                color: Theme.of(context).iconTheme.color, // Use theme icon color
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
        height: 300, // Set the default height of the bottom sheet
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Add New Task',
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Neumorphic(
              style: neumorphicBottomSheetStyle(Get.context!),
              child: TextField(
                controller: taskControllerInput,
                decoration: InputDecoration(
                  hintText: 'Enter task',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                autofocus: true,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Save button with Neumorphic style
                SizedBox(
                  width: 160, // Adjust width for Save button
                  child: NeumorphicButton(
                    style:
                        neumorphicButtonStyle(Get.context!, isSelected: false),
                    onPressed: () {
                      final task = taskControllerInput.text.trim();
                      if (task.isNotEmpty) {
                        taskController.addTask(task);
                      }
                      Get.back(); // Close the bottom sheet
                    },
                    child: Center(
                      child: Text(
                        'Save',
                        style: Theme.of(Get.context!).textTheme.button,
                      ),
                    ),
                  ),
                ),
                // Cancel button with Neumorphic style
                SizedBox(
                  width: 160, // Adjust width for Cancel button
                  child: NeumorphicButton(
                    style:
                        neumorphicButtonStyle(Get.context!, isSelected: false),
                    onPressed: () {
                      Get.back(); // Close the bottom sheet
                    },
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: Theme.of(Get.context!).textTheme.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    );
  }
}
