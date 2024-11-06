// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; // Import Neumorphic package
// import 'package:get/get.dart';
// import 'package:goalsync/controller/task_controller.dart';
// import 'package:goalsync/screens/task_screen.dart';
// import 'package:goalsync/screens/taskwidgets_homescreen.dart';
// import 'package:goalsync/screens/theme.dart';
// import 'package:goalsync/service/drawer.dart';
//
// import '../controller/theme_controller.dart';
//
// class HabitScreen extends StatelessWidget {
//   final TextEditingController taskControllerInput = TextEditingController();
//
//   final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final TaskController taskController = Get.find();
//
//     return Scaffold(
//       key: drawerKey,
//       appBar: _appBar(context),
//       drawer: MyDrawer(),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(17.0),
//                 child: Row(
//                   children: [],
//                 ),
//               ),
//               Expanded(
//                 child: Obx(() {
//                   if (taskController.isTaskSelected.length <
//                       taskController.taskList.length) {
//                     taskController.isTaskSelected.addAll(
//                       List.generate(
//                         taskController.taskList.length -
//                             taskController.isTaskSelected.length,
//                         (_) => false,
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     itemCount: taskController.taskList.length,
//                     itemBuilder: (context, index) {
//                       final task = taskController.taskList[index];
//
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Dismissible(
//                               key: ValueKey(task),
//                               background: Container(
//                                 color: Colors.blue.shade300,
//                                 child: Icon(Icons.delete_outline, size: 35, color: Colors.white),
//                                 alignment: Alignment.centerRight,
//                                 padding: EdgeInsets.symmetric(horizontal: 20),
//                               ),
//                               direction: DismissDirection.endToStart,
//                               onDismissed: (direction) {
//                                 taskController.deleteTask(index);
//                               },
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.to(TaskScreen(
//                                           taskName: task,
//                                           isTaskChecked: true,
//                                           index: index,
//                                           taskId: taskController.taskIdList[index],
//                                         ));
//                                       },
//                                       onLongPress: () {
//                                         _showOptionsDialog(context, taskController, index);
//                                       },
//                                       child: Stack(
//                                         clipBehavior: Clip.none,  // Allow overlap outside bounds
//                                         children: [
//                                           Container(
//                                             height: 58,
//                                             width: double.infinity,
//                                             padding: EdgeInsets.all(15.0),
//                                             decoration: BoxDecoration(
//                                               color: Theme.of(context).brightness == Brightness.light
//                                                   ? Color(0xFFF5F5FA)
//                                                   : Color(0xFF2E2E2E),
//                                               borderRadius: BorderRadius.circular(8),
//                                               boxShadow: getCurrentThemeBoxShadows(context),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   task,
//                                                   style: TextStyle(
//                                                     color: Theme.of(context).brightness == Brightness.light
//                                                         ? Colors.black
//                                                         : Colors.white,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//
//                                           // Pin icon at the top-left corner (overlapping the task card)
//                                           Positioned(
//                                             top: -10,
//                                             left: -10,
//                                             child: Obx(() => Visibility(
//                                               visible: taskController.pinnedTasks.contains(task),
//                                               child: Transform.rotate(
//                                                 angle: 0.3,
//                                                 child: Icon(
//                                                   Icons.push_pin_outlined,
//                                                   color: Theme.of(context).brightness == Brightness.light
//                                                       ? Colors.black
//                                                       : Colors.white,
//                                                   size: 20,  // Adjust the icon size as needed
//                                                 ),
//                                               ),
//                                             )),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//
//                                   GestureDetector(
//                                     onTap: () {
//                                       taskController.toggleTaskSelection(
//                                         index,
//                                         !taskController.isTaskSelected[index],
//                                       );
//                                     },
//                                     child: Container(
//                                       height: 80,
//                                       width: 80,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(left: 10.0),
//                                         child: Stack(
//                                           alignment: Alignment.center,
//                                           children: [
//                                             Container(
//                                               width: 30,
//                                               height: 30,
//                                               child: Image.asset(
//                                                 Theme.of(context).brightness == Brightness.light
//                                                     ? 'assets/images/img_1.png'
//                                                     : 'assets/images/img.png',
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                             if (taskController.isTaskSelected[index])
//                                               Center(
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.only(left: 1.0, bottom: 3),
//                                                   child: Container(
//                                                     width: 16,
//                                                     height: 16,
//                                                     child: Image.asset(
//                                                       Theme.of(context).brightness == Brightness.light
//                                                           ? 'assets/images/darktic.png'
//                                                           : 'assets/images/lighttic.png',
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//
//                     },
//                   );
//                 }),
//               ),
//             ],
//           ),
//           // Positioned(
//           //   bottom: 0,
//           //   left: 0,
//           //   right: 0,
//           //   child: Center(
//           //     child: FloatingActionButton(
//           //       onPressed: () {
//           //         _showAddTaskBottomSheet(context);
//           //       },
//           //       child: Icon(
//           //         Icons.add,
//           //         color: subheadingStyle(context).color,
//           //       ),
//           //     ),
//           //   ),
//           // ),
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
//                 Utils.showAddTaskBottomSheet(context);
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
//   void _showOptionsDialog(BuildContext context, TaskController taskController, int index) {
//     final task = taskController.taskList[index];
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(0),
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(0),
//             ),
//           ),
//           child: SizedBox(
//             width: 200,
//             height: 130,
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ListTile(
//                       leading: Icon(taskController.pinnedTasks.contains(task)
//                           ? Icons.push_pin
//                           : Icons.push_pin_outlined),
//                       title: Text(
//                         taskController.pinnedTasks.contains(task)
//                             ? 'Unpin'
//                             : 'Pin',
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       onTap: () {
//                         if (!taskController.pinnedTasks.contains(task) &&
//                             taskController.pinnedTasks.length >= 2) {
//                           // Show custom toast if trying to pin more than 2 tasks
//                           Utils.showCustomToast(
//                               context, 'You can only pin up to 2 tasks.');
//                         } else {
//                           taskController.pinTask(index);
//                         }
//                         Navigator.of(context).pop(); // Close dialog
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.share),
//                       title: Text('Share', style: TextStyle(fontSize: 14)),
//                       onTap: () {
//                         _shareTask(task);
//                         Navigator.of(context).pop(); // Close dialog
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _shareTask(String task) {}
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';//add this
import 'package:get/get.dart';
import 'package:goalsync/controller/task_controller.dart';
import 'package:goalsync/screens/recording_screen.dart';
import 'package:goalsync/screens/task_screen.dart';
import 'package:goalsync/screens/taskwidgets_homescreen.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:goalsync/service/drawer.dart';

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
      body: Stack(
        children: [
          Column(
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

                  return ListView.builder(
                    itemCount: taskController.taskList.length,
                    itemBuilder: (context, index) {
                      final task = taskController.taskList[index];
                      final isTimeUnit = taskController.taskUnit[index] == 1;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Dismissible(
                              key: ValueKey(task),
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(TaskScreen(
                                          taskName: task,
                                          isTaskChecked: true,
                                          index: index,
                                          taskId: taskController.taskIdList[index],
                                        ));
                                      },
                                      onLongPress: () {
                                        _showOptionsDialog(context, taskController, index);
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            height: 58,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).brightness == Brightness.light
                                                  ? Color(0xFFF5F5FA)
                                                  : Color(0xFF2E2E2E),
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: getCurrentThemeBoxShadows(context),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  task,
                                                  style: TextStyle(
                                                    color: Theme.of(context).brightness == Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            left: -10,
                                            child: Obx(() => Visibility(
                                              visible: taskController.pinnedTasks.contains(task),
                                              child: Transform.rotate(
                                                angle: 0.3,
                                                child: Icon(
                                                  Icons.push_pin_outlined,
                                                  color: Theme.of(context).brightness == Brightness.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DateTime startTime = DateTime.now(); // Replace with actual start time
                                      DateTime endTime = DateTime.now().add(Duration(hours: 1)); // Replace with actual end time
                                      taskController.toggleTaskSelection(
                                        index,
                                        !taskController.isTaskSelected[index],
                                        startTime,
                                        endTime,
                                      );
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            if (isTimeUnit)
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.asset(
                                                  'assets/images/circle.png',
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            else
                                              Container(
                                                width: 30,
                                                height: 30,
                                                child: Image.asset(
                                                  Theme.of(context).brightness == Brightness.light
                                                      ? 'assets/images/img_1.png'
                                                      : 'assets/images/img.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            if (isTimeUnit)
                                              Obx(() => Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => RecordingScreen(
                                                      taskName: task,
                                                      taskId: taskController.taskIdList[index],
                                                    ));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0, bottom: 1),
                                                    child: Icon(
                                                      (taskController.isPlaying[index] ?? false) ? Icons.pause : Icons.play_arrow,
                                                      size: 24,
                                                      color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            if (!isTimeUnit && taskController.isTaskSelected[index])
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 1.0, bottom: 3),
                                                  child: Container(
                                                    width: 16,
                                                    height: 16,
                                                    child: Image.asset(
                                                      Theme.of(context).brightness == Brightness.light
                                                          ? 'assets/images/darktic.png'
                                                          : 'assets/images/lighttic.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                ),
              ),
            ],
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
        style: appBarStyle(context),
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
                Utils.showAddTaskBottomSheet(context);
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

  void _showOptionsDialog(BuildContext context, TaskController taskController, int index) {
    final task = taskController.taskList[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: SizedBox(
            width: 200,
            height: 130,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(taskController.pinnedTasks.contains(task)
                          ? Icons.push_pin
                          : Icons.push_pin_outlined),
                      title: Text(
                        taskController.pinnedTasks.contains(task)
                            ? 'Unpin'
                            : 'Pin',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        if (!taskController.pinnedTasks.contains(task) &&
                            taskController.pinnedTasks.length >= 2) {
                          Utils.showCustomToast(context, 'You can only pin up to 2 tasks.');
                        } else {
                          taskController.pinTask(index);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share', style: TextStyle(fontSize: 14)),
                      onTap: () {
                        _shareTask(task);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _shareTask(String task) {}
}

