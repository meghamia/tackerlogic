import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';//add this
import 'package:get/get.dart';
import 'package:goalsync/screens/progress_screen.dart';
import 'package:goalsync/screens/task_screen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/task_controller.dart';
import 'theme.dart';

class MyCalendar extends StatelessWidget {
  final int taskId;
  final String taskName;
  final int index;

  MyCalendar({
    required this.taskId,
    required this.taskName,
    required this.index
  });
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    final ThemeData themeData = Theme.of(context);
    final isLightTheme = themeData.brightness == Brightness.light;
    DateTime startDate = DateTime.now().subtract(Duration(days: 6));
    DateTime endDate = DateTime.now();

    taskController.fetchProgressDataForDateRange(startDate, endDate, taskId);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Neumorphic(
          style: appBarStyle(context),
          child: AppBar(
            title: Text(taskName, style: HeadingStyle(context)),

            // title: Text(
            //   "Calendar",
            //   style: HeadingStyle(context),
            // ),
            centerTitle: true,
            iconTheme: IconThemeData(
                color: isLightTheme ? Colors.black : Colors.white),
          ),
        ),
      ),
      body: Obx(() {
        print('Completion Dates: ${taskController.completionDates}');

        return ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 390,
                      height: 70,
                      child: neumorphicGraphContainer(
                        context,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust to place buttons properly
                            children: [Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => TaskScreen(
                                    taskName: taskController.taskList[index],
                                    isTaskChecked: true,
                                    index: index,
                                    taskId: taskController.taskIdList[index],
                                  ));
                                },
                                child: Text(
                                  'Tracker',
                                  style: subheadingStyle(context),
                                ),
                              ),
                              // Add Spacer to center the Insights button
                              Spacer(),
                              Container(
                                decoration: taskSelectedStyle(isSelected: true), // Use the custom style
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      Theme.of(context).brightness == Brightness.light
                                          ? 'assets/images/img_5.png'
                                          : 'assets/images/img_4.png',
                                      width: 150,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      'Insights',
                                      style: subheadingStyle(context),
                                    ),
                                  ],
                                ),
                              ),
                              // Add Spacer to push Progress to the right
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ProgressScreen(
                                    taskName: taskController.taskList[index],
                                    index: index,
                                    taskId: taskController.taskIdList[index],
                                    isTaskChecked: true,


                                  ));
                                },
                                child: Text(
                                  'Progress',
                                  style: subheadingStyle(context),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Neumorphic(
                style: getCalendarContainerStyle(context),
                child: SizedBox(
                  height: 370,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TableCalendar(
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        defaultDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        // markerDecoration: BoxDecoration(
                        //   color: Colors.red,
                        //   shape: BoxShape.circle,
                        // ),
                        defaultTextStyle: drawerTextStyle(context),
                        weekendTextStyle: drawerTextStyle(context),
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        leftChevronVisible: true,
                        rightChevronVisible: true,
                        headerMargin: EdgeInsets.only(bottom: 8.0),
                        titleTextStyle: subheadingStyle(context),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: drawerTextStyle(context),
                        weekendStyle: drawerTextStyle(context),
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          final dateKey = DateFormat('yyyy-MM-dd').format(date);
                          final isCompleted =
                              taskController.completionDates[dateKey] ?? false;

                          if (isCompleted) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 1.5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  date.day.toString(),
                                  style: subheadingStyle(context)
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
