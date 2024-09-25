import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/task_controller.dart';
import 'theme.dart';


class MyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    final ThemeData themeData = Theme.of(context);
    final isLightTheme = themeData.brightness == Brightness.light;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Neumorphic(
          style: neumorphicButtonStyle(context, isSelected: false),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // Transparent background
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: AppBar(
              title: const Text("Calendar"),
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: isLightTheme ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
      body: Obx(() {
        print('Completion Dates: ${taskController.completionDates}');

        return ListView(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(11), // Match this with your neumorphicGraphContainer's radius

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 310,
                      height: 70,

                          child: neumorphicGraphContainer(
                            context,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Simple text for Tracker
                                  SizedBox(width: 24,),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back(); // Navigate back to TaskScreen
                                    },
                                    child: Text(
                                      'Tracker', // Simple text for Tracker button
                                      style: getDrawerButtonTextStyle(context),
                                    ),
                                  ),
                                  SizedBox(width: 14,),
                                  Container(
                                    decoration: taskSelectedStyle(isSelected: true), // Use the custom style
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          Theme.of(context).brightness == Brightness.light
                                              ? 'assets/images/img_5.png' // Path to light theme image
                                              : 'assets/images/img_4.png', // Default dark theme image
                                          width: 150, // Match the container's width
                                          height: 48, // Match the container's height
                                          fit: BoxFit.cover, // Adjust the image to cover the container
                                        ),

                                        Text(
                                          'Insights',
                                          style: getDrawerButtonTextStyle(context), // Custom text style
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Neumorphic(
                style: getCalendarContainerStyle(context),
                child: SizedBox(
                  height: 380, // Adjust height as needed
                  child: Padding(
                    padding: const EdgeInsets.all(
                        8.0), // Padding inside the neumorphic container
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
                        markerDecoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          final dateKey = DateFormat('yyyy-MM-dd').format(date);
                          final completionStatus =
                              taskController.completionDates[dateKey];

                          if (completionStatus != null && completionStatus) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 1.5),
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                          return SizedBox();
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
