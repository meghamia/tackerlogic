import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; // Import Neumorphic package
import 'package:get/get.dart';
import 'package:goalsync/controller/task_controller.dart';
import 'package:goalsync/screens/task_screen.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:goalsync/service/drawer.dart';
import 'package:intl/intl.dart';

import '../controller/theme_controller.dart';

// class HabitScreen extends StatelessWidget {
//   final TextEditingController taskControllerInput = TextEditingController();
//
//   final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final TaskController taskController = Get.find();
//     return Scaffold(
//       key: drawerKey,
//       appBar: _appBar(context),
//       drawer: MyDrawer(),
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
//                 separatorBuilder: (context, index) => SizedBox(height: 16),
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
//                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Container(
//                         height: 60,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Get.to(TaskScreen(
//                                     taskName: taskController.taskList[index],
//                                     isTaskChecked: true,
//                                     index: index,
//                                   ));
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(15.0),
//                                   constraints: BoxConstraints(
//                                     maxWidth:
//                                         MediaQuery.of(context).size.width *
//                                             0.85,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).brightness ==
//                                             Brightness.light
//                                         ? Color(
//                                             0xFFF5F5FA) // Light theme background color
//                                         : Color(
//                                             0xFF2E2E2E), // Dark theme background color
//                                     borderRadius: BorderRadius.circular(8),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Theme.of(context).brightness ==
//                                                 Brightness.light
//                                             ? Color(
//                                                 0xFFE0E0E0) // Light shadow for depth in light theme
//                                             : Color(
//                                                 0xFF1E1E1E), // Dark shadow for depth in dark theme
//                                         offset: Offset(6, 6), blurRadius: 12,
//                                       ),
//                                       BoxShadow(
//                                         color: Theme.of(context).brightness ==
//                                                 Brightness.light
//                                             ? Color(0xFFFFFFFF).withOpacity(
//                                                 0.4) // Light shadow for an embedded effect in light theme
//                                             : Color(
//                                                 0xFF3E3E3E), // Light shadow for an embedded effect in dark theme
//                                         offset: Offset(-6, -6),
//                                         blurRadius: 12,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 10.0), // Shift text to the right
//                                     child: Text(
//                                       taskController.taskList[index],
//                                       style: titleStyle(context),
//                                       // TextStyle(
//                                       //   color: Theme.of(context).brightness == Brightness.light ? Colors.black // Text color is black in light theme
//                                       //       : Colors
//                                       //           .white, // Text color is white in dark theme
//                                       //   fontSize: 18,
//                                       // ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             GestureDetector(
//                               onTap: () {
//                                 taskController.toggleTaskSelection(
//                                   index,
//                                   !taskController.isTaskSelected[index],
//                                 );
//                               },
//                               child: Container(
//                                 // You can add padding, margin, or other styles if needed
//                                 // decoration: BoxDecoration(
//                                 //   color: Colors.transparent, // Set a transparent background if desired
//                                 //   borderRadius: BorderRadius.circular(3), // Optional border radius
//                                 //   boxShadow: getCurrentThemeBoxShadows(context), // Add shadows if needed
//                                 // ),
//                                 child: Stack(
//                                   alignment: Alignment
//                                       .center, // Center the items within the Stack
//                                   children: [
//                                     Image.asset(
//                                       Theme.of(context).brightness ==
//                                               Brightness.light
//                                           ? 'assets/images/lightbox.png' // Light theme image
//                                           : 'assets/images/darknox.png', // Dark theme image
//                                       height: 70,
//                                       width: 70,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Align(
//                                       alignment: Alignment.center,
//                                       child: Icon(
//                                         Icons.check,
//                                         color: taskController
//                                                 .isTaskSelected[index]
//                                             ? (Theme.of(context).brightness ==
//                                                     Brightness.light
//                                                 ? Colors.black
//                                                 : Colors.white)
//                                             : Colors.transparent,
//                                         size: 22,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
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
//   PreferredSizeWidget _appBar(BuildContext context) {
//     final ThemeController themeController = Get.find();
//     final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
//
//     return PreferredSize(
//       preferredSize: Size.fromHeight(kToolbarHeight),
//       child: Neumorphic(
//         style: neumorphicAppBarStyle(
//           context,
//         ),
//         child: AppBar(
//           title: Text("My Habits", style: HeadingStyle(context)),
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(
//               Icons.menu,
//               color: isDarkTheme ? Colors.white : Colors.black,
//             ),
//             onPressed: () {
//               drawerKey.currentState?.openDrawer();
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 _showAddTaskBottomSheet(context);
//               },
//               icon: Icon(
//                 Icons.add,
//                 color: subheadingStyle(context).color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddTaskBottomSheet(BuildContext context) {
//     final TaskController taskController = Get.find();
//     final TextEditingController taskControllerInput = TextEditingController();
//     final FocusNode taskInputFocusNode = FocusNode();
//
//     Get.bottomSheet(
//       ClipRRect(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//         child: Container(
//           height: 300,
//           padding: EdgeInsets.all(16.0),
//           color: Theme.of(context).scaffoldBackgroundColor,
//           child: Column(
//             children: [
//               Text(
//                 'Add New Task',
//                 style: subheadingStyle(context),
//               ),
//               SizedBox(height: 20),
//               GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).requestFocus(taskInputFocusNode);
//                 },
//                 child: Stack(
//                   alignment: Alignment.centerLeft,
//                   children: [
//                     taskBackgroundImage(context, 60),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 14.0),
//                       child: TextFormField(
//                         controller: taskControllerInput,
//                         focusNode: taskInputFocusNode,
//                         style: titleStyle(context),
//                         decoration: InputDecoration(
//                           hintText: 'Enter Task',
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.zero,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40),
//               addButton(context, () {
//                 final task = taskControllerInput.text.trim();
//                 if (task.isNotEmpty) {
//                   taskController.addTask(task);
//                   final taskIndex = taskController.taskList.length - 1;
//                   taskController.addTaskForDate(DateTime.now(), taskIndex);
//                 }
//                 Get.back();
//               }),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//     );
//   }
// }


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
              children: [],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (taskController.isTaskSelected.length < taskController.taskList.length) {
                taskController.isTaskSelected.addAll(
                  List.generate(
                    taskController.taskList.length - taskController.isTaskSelected.length,
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
                      child: Icon(Icons.delete_outline, size: 35, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      taskController.deleteTask(index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:16.0),
                      child: Container(
                        height: 58,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? Color(0xFFF5F5FA)
                                        : Color(0xFF2E2E2E),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: getCurrentThemeBoxShadows(context), // Call the function here
                                  ),
                                  child: Text(
                                    taskController.taskList[index],
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 2,),

                            GestureDetector(
                                onTap: () {
                                  taskController.isTaskSelected[index] = !taskController.isTaskSelected[index];
                                  taskController.update();
                                },

                                  child: Container (
                                    height: 90,
                                    width: 90,
                                    alignment: Alignment.center,

                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          Theme.of(context).brightness == Brightness.light
                                              ? 'assets/images/lightbox.png'
                                              : 'assets/images/darknox.png',
                                          height: 90,
                                          width: 90,

                                        ),
                                        if (taskController.isTaskSelected[index])
                                          Icon(
                                            Icons.check,
                                            color: Theme.of(context).brightness == Brightness.light
                                                ? Colors.black
                                                : Colors.white,
                                            size: 25,
                                          ),
                                      ],
                                    ),
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
        style: neumorphicAppBarStyle(
          context,
        ),
        child: AppBar(
          title: Text("My Habits", style: HeadingStyle(context)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: isDarkTheme ? Colors.white : Colors.black,
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
                color: subheadingStyle(context).color,
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
    final FocusNode taskInputFocusNode = FocusNode();

    Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        child: Container(
          height: 300,
          padding: EdgeInsets.all(16.0),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Text(
                'Add New Task',
                style: subheadingStyle(context),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(taskInputFocusNode);
                },
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    taskBackgroundImage(context, 60),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: TextFormField(
                        controller: taskControllerInput,
                        focusNode: taskInputFocusNode,
                        style: titleStyle(context),
                        decoration: InputDecoration(
                          hintText: 'Enter Task',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              addButton(context, () {
                final task = taskControllerInput.text.trim();
                if (task.isNotEmpty) {
                  taskController.addTask(task);
                  final taskIndex = taskController.taskList.length - 1;
                  taskController.addTaskForDate(DateTime.now(), taskIndex);
                }
                Get.back();
              }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}


