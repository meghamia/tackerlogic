import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/task_controller.dart';

class MyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController()); // Ensure the controller is initialized

    return Scaffold(
      appBar: AppBar(
        title: Text('My Calendar'),
      ),
      body: Obx(() {
        print('Completion Dates: ${taskController.completionDates}'); // Debug print

        return TableCalendar(
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
              final completionStatus = taskController.completionDates[dateKey];

              print('Date: $dateKey, Completion Status: $completionStatus'); // Debug print

              if (completionStatus != null && completionStatus) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  color: Colors.red, // Mark completed dates in red
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
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
        );
      }),
    );
  }
}
