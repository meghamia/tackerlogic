import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goalsync/screens/calendar_screen.dart';
import 'package:goalsync/screens/habit_screen.dart';
import 'package:goalsync/screens/progress_screen.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:goalsync/screens/tracker_widget.dart';
import 'package:intl/intl.dart';
import '../controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  final String taskName;
  final bool isTaskChecked;
  final int index;
  final int taskId;

  TaskScreen({
    required this.taskName,
    required this.isTaskChecked,
    required this.index,
    required this.taskId,
  });

  String get trackedDate {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  Future<List<double>> fetchProgressData(
      TaskController taskController, DateTime startDate, int taskId) async {
    try {
      DateTime endDate = startDate.add(Duration(days: 6));

      final progressData = await taskController.fetchProgressDataForDateRange(
          startDate, endDate, taskId);

      return progressData;
    } catch (e) {
      print('Error fetching progress data: $e');
      return List<double>.filled(7, 0.0);
    }
  }

  final Rx<DateTime> currentStartDate =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).obs;

  void moveToPreviousWeek() {
    currentStartDate.value = currentStartDate.value.subtract(Duration(days: 7));
  }

  void moveToNextWeek(TaskController taskController) {
    DateTime nextWeekStartDate = currentStartDate.value.add(Duration(days: 7));

    DateTime currentWeekStartDate = getStartOfWeek(DateTime.now());

    if (nextWeekStartDate.isBefore(currentWeekStartDate) ||
        nextWeekStartDate.isAtSameMomentAs(currentWeekStartDate)) {
      currentStartDate.value = nextWeekStartDate;

      fetchProgressData(taskController, currentStartDate.value, taskId);
    }
  }

  DateTime getStartOfWeek(DateTime date) {
    return date.subtract(
        Duration(days: date.weekday - 1)); //mon is my startinf of week
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime currentEndDate = currentStartDate.value.add(Duration(days: 6));

    final TaskController taskController = Get.find();
    final ThemeData themeData = Theme.of(context);
    final isLightTheme = themeData.brightness == Brightness.light;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Neumorphic(
          style: neumorphicAppBarStyle(
            context,
          ),
          child: Container(
            child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offAll(() => HabitScreen());
                },
              ),
              title: Text(taskName, style: HeadingStyle(context)),
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: isLightTheme ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          TrackerWidget(
            taskName: taskController.taskList[index],
            isTaskChecked: true,
            index: index,
            taskId: taskController.taskIdList[index],
          ),
          Obx(() {
            return FutureBuilder<List<double>>(
              future: fetchProgressData(
                  taskController, currentStartDate.value, taskId),
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
                final daysOfWeek = [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun'
                ];
                double maxValue = progressData.reduce((a, b) => a > b ? a : b);
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),

                        Container(
                          width: 310,
                          child: neumorphicGraphContainer(
                            context,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () {
                                            moveToPreviousWeek();
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () {
                                            moveToNextWeek(taskController);
                                          },
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: Text(
                                        'Weekly Progress',
                                        style: subheadingStyle(context),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      child: Obx(() {
                                        DateTime currentEndDate =
                                            currentStartDate.value
                                                .add(Duration(days: 6));
                                        return Text(
                                          '${DateFormat('dd MMM').format(currentStartDate.value)} - ${DateFormat('dd MMM').format(currentEndDate)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),

                        // Line Chart Container
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 300, // Ensure height is defined
                            child: neumorphicGraphContainer(
                              context,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: LineChart(
                                  LineChartData(
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          getTitlesWidget: (value, meta) {
                                            if (value >= 0 && value < 7) {
                                              final dayLabel =
                                                  daysOfWeek[value.toInt()];
                                              return SideTitleWidget(
                                                axisSide: meta.axisSide,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                                  child: Text(
                                                    dayLabel,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 10,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            if (value >= 0 && value <= 6) {
                                              return SideTitleWidget(
                                                axisSide: meta.axisSide,
                                                child: Text(
                                                  '${value.toInt()}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              );
                                            }
                                            return SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                    ),
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      horizontalInterval: 1,
                                      getDrawingHorizontalLine: (value) {
                                        if (value >= 0 && value <= 6) {
                                          return FlLine(
                                            color: Colors.grey,
                                            strokeWidth: 1,
                                          );
                                        }
                                        return FlLine(
                                          color: Colors.grey,
                                          strokeWidth: 1,
                                        );
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    minX: -0.4,
                                    maxX: daysOfWeek.length.toDouble() - 1,
                                    minY: 0,
                                    maxY: 6.5,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: List.generate(
                                            progressData.length, (index) {
                                          return FlSpot(index.toDouble(),
                                              progressData[index]);
                                        }),
                                        isCurved: true,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        barWidth: 2,
                                        belowBarData: BarAreaData(show: false),
                                        dotData: FlDotData(show: false),
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
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
