import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../controller/task_controller.dart';
import 'theme.dart';
import 'package:tracker/screens/calendar_screen.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../controller/task_controller.dart';
import 'theme.dart';
import 'package:tracker/screens/calendar_screen.dart';

class TaskScreen extends StatelessWidget {
  final String taskName;
  final bool isTaskChecked;
  final int index; // Add index parameter

  TaskScreen({
    required this.taskName,
    required this.isTaskChecked,
    required this.index, // Add index parameter
  });

  Future<List<double>> fetchAllProgressData(
      TaskController taskController) async {
    try {
      final progressData = await taskController.fetchProgressDataForLastDays(7);
      print('Fetched Progress Data for Last 7 Days: $progressData');
      return progressData;
    } catch (e) {
      print('Error fetching progress data: $e');
      return List<double>.filled(7, 0.0); // Return zeros if there's an error
    }
  }

  Future<void> updateTaskStatus(
      TaskController taskController, int index, bool isCompleted) async {
    try {
      // Update the task status using the index
      await taskController.updateTaskStatusByIndex(index, isCompleted);
      print('Task status updated: Index=$index, isCompleted=$isCompleted');
    } catch (e) {
      print('Error updating task status: $e');
    }
  }


  @override
// Inside TaskScreen class

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    final ThemeData themeData = Theme.of(context);
    final isLightTheme = themeData.brightness == Brightness.light;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Neumorphic(
          style: neumorphicButtonStyle(
            context,
            isSelected: false,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppBar(
              title: Text(
                taskName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: isLightTheme ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<double>>(
        future: fetchAllProgressData(taskController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          final progressData = isTaskChecked
              ? snapshot.data!
              : List<double>.filled(7, 0.0);

          final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

          final currentWeekBarGroups = List.generate(7, (index) {
            double value =
            index < progressData.length ? progressData[index] : 0.0;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: value,
                  color: value > 0 ? Colors.blue : Colors.grey,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          });

          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Neumorphic(
                        style:
                        neumorphicButtonStyle(context, isSelected: false),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              NeumorphicButton(
                                onPressed: () async {
                                  await updateTaskStatus(
                                    taskController,
                                    index, // Pass the index
                                    true,  // Mark as completed
                                  );
                                },
                                style: NeumorphicStyle(
                                  depth: -7,
                                  intensity: 0.8,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(8)),
                                  lightSource: LightSource.bottomLeft,
                                  color: Theme.of(context)
                                      .cardColor,
                                ),
                                child: Container(
                                  width: 70,
                                  height: 20,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tracker',
                                    style: getDrawerButtonTextStyle(context),
                                  ),
                                ),
                              ),
                              NeumorphicButton(
                                onPressed: () async {
                                  await updateTaskStatus(
                                    taskController,
                                    index, // Pass the index
                                    false, // Mark as not completed
                                  );
                                },
                                style: neumorphicButtonStyle(context,
                                    isSelected: false),
                                child: Text(
                                  'Insights',
                                  style: getDrawerButtonTextStyle(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 300,
                      child: Neumorphic(
                        style: neumorphicGraphContainerStyle(context),
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            barGroups: currentWeekBarGroups,
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    final dayLabel = daysOfWeek[value.toInt() % 7];
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(dayLabel,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text('${value.toInt()}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    );
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: true),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: const Color(0xff37434d),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
