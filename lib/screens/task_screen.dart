import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goalsync/screens/calendar_screen.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:intl/intl.dart';
import '../controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  final String taskName;
  final bool isTaskChecked;
  final int index;

  TaskScreen({
    required this.taskName,
    required this.isTaskChecked,
    required this.index,
  });

  String get trackedDate {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  Future<List<double>> fetchProgressData(TaskController taskController) async {
    try {
      final progressData = await taskController.fetchProgressDataForTrackedDate(
          trackedDate, index);
      return progressData;
    } catch (e) {
      print('Error fetching progress data: $e');
      return List<double>.filled(7, 0.0); // Default values if there's an error
    }
  }

  Future<void> updateTaskStatus(
      TaskController taskController, int index, bool isCompleted) async {
    try {
      await taskController.updateTaskStatusByIndex(index, isCompleted);
      print('Task status updated: Index=$index, isCompleted=$isCompleted');
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  final Rx<DateTime> currentStartDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).obs;

  void moveToPreviousWeek() {
    currentStartDate.value = currentStartDate.value.subtract(Duration(days: 7));
  }

  void moveToNextWeek() {
    currentStartDate.value = currentStartDate.value.add(Duration(days: 7));
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
              title: Text(
                taskName,
                  style: HeadingStyle(context)
              ),
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: isLightTheme ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<double>>(
        future: fetchProgressData(taskController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }
          final progressData =
              isTaskChecked ? snapshot.data! : List<double>.filled(7, 0.0);

          final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          double maxValue = progressData.reduce((a, b) => a > b ? a : b);
          final currentWeekBarGroups = List.generate(7, (index) {
            double value =
                index < progressData.length ? progressData[index] : 0.0;
            print('Index: $index, Day: ${daysOfWeek[index]}, Value: $value');
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11),

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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: taskSelectedStyle(isSelected: true),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? 'assets/images/img_5.png' // Path to light theme image
                                            : 'assets/images/img_4.png', // Default dark theme image
                                        width: 150,
                                        height: 48, // Match the container's height
                                        fit: BoxFit
                                            .cover, // Adjust the image to cover the container
                                      ),
                                      Text(
                                        'Tracker',
                                        style: subheadingStyle(context),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                // Insights text button
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => MyCalendar());
                                  },
                                  child: Text(
                                    'Insights',
                                    style: subheadingStyle(context),
                                    // style: getDrawerButtonTextStyle(context),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 310,
                    child: neumorphicGraphContainer(
                      context,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            11), // Match this with your neumorphicGraphContainer's radius
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            alignment: Alignment
                                .center, // Center align the stack's content
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Spread the icons to the edges
                                children: [
                                  // Back arrow at the left corner
                                  IconButton(
                                    icon: Icon(
                                        Icons.arrow_back), // Back arrow icon
                                    onPressed: () {
                                      moveToPreviousWeek();

                                      // Define the action for the back arrow
                                    },
                                  ),
                                  // Forward arrow at the right corner
                                  IconButton(
                                    icon: Icon(Icons
                                        .arrow_forward), // Forward arrow icon
                                    onPressed: () {
                                      moveToNextWeek();

                                      // Define the action for the forward arrow
                                    },
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0, // Center title vertically
                                child: Text(
                                  'Weekly Progress',
                                  style: subheadingStyle(context),

                                ),
                              ),
                              Positioned(
                                bottom: 5, // Position this text below the title
                                child: Text(
                                  '${DateFormat('dd MMM').format(currentStartDate.value)} - ${DateFormat('dd MMM').format(currentEndDate)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
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
                      child: neumorphicGraphContainer(
                        context,
                        child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 16.0,
                              bottom: 8.0,
                            ),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 3.0,
                                              ),
                                              child: Text(
                                                dayLabel,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
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
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
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
                                minX: -0.4, // Adjusted for padding
                                maxX: daysOfWeek.length.toDouble() - 1,
                                minY: 0,
                                maxY: 6.5,
                                lineBarsData: [
                                  LineChartBarData(
                                    //spots:  currentWeekData, // Ensure this matches your database structure
                                    isCurved:
                                        true, // Smooth curves for the line chart
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors
                                            .black // Line color for light theme
                                        : Colors
                                            .white, // Line color for dark theme
                                    barWidth: 3,
                                    belowBarData: BarAreaData(
                                      show: false,
                                    ),
                                    dotData: FlDotData(show: false),
                                  ),
                                ],
                              ),
                            )),
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


