import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';//add this
import 'package:get/get.dart';
import 'package:goalsync/screens/taskwidgets_homescreen.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/task_controller.dart';
import '../database/dbhelper.dart';
import 'habit_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  final _databaseHelper = DatabaseHelper();
  final TaskController taskCtrl = Get.put(TaskController());
  final TextEditingController textCtrl = TextEditingController();
  final TextEditingController additionalFieldController =
  TextEditingController();
  String? selectedUnitLabel;
  String? selectedUnitValue; // Variable for unit value
  int? selectedUnitId;

  bool isDropdownExpanded = false;
  String? selectedUnit;
  List<Map<String, dynamic>> units = [];

  @override
  Widget build(BuildContext context) {
    _fetchUnits();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: NeumorphicButton(
                style: neumorphicButtonStyle(context, isSelected: false),
                onPressed: () {
                  _showAddTaskBottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add Habit', style: subheadingStyle(context)),
                    SizedBox(width: 5),
                    Icon(Icons.add, color: subheadingStyle(context).color),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchUnits() async {
    final dbHelper = DatabaseHelper();
    units = await dbHelper.getUnits();
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    final FocusNode taskInputFocusNode = FocusNode();

    Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                height: isDropdownExpanded ? 900 : 500,
                padding: EdgeInsets.all(16.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Text('Add New Task', style: subheadingStyle(context)),
                          SizedBox(height: 20),
                          _buildTaskInputField(taskInputFocusNode, context),
                          SizedBox(height: 20),
                          _buildUnitDropdown(setState, context),
                          SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              taskBackgroundImage(context, 60),
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: TextFormField(
                                  controller: additionalFieldController,
                                  style: titleStyle(context),
                                  decoration: InputDecoration(
                                    hintText: 'Target',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              // Display the selected unit value on the right
                              if (selectedUnitValue != null)
                                Positioned(
                                  right: 10.0,
                                  child: Text(
                                    selectedUnitValue!, // Display the selected unit value
                                    style: titleStyle(context),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 30),
                          addButton(context, () async {
                            final task = textCtrl.text.trim();
                            if (task.isNotEmpty && selectedUnit != null) {
                              // Fetch the unitId based on the selected unit label
                              final unitId = await _databaseHelper
                                  .fetchUnitIdByLabel(selectedUnit!);
                              final additionalInfo = additionalFieldController
                                  .text
                                  .trim(); // New field value

                              int targetValue =
                              0; // Default value for target if not provided
                              if (additionalInfo.isNotEmpty) {
                                try {
                                  if (selectedUnitValue == "hours") {
                                    targetValue =
                                        int.parse(additionalInfo) * 60;
                                  } else {
                                    // For other units, just use the value as-is
                                    targetValue = int.parse(additionalInfo);
                                  }
                                } catch (e) {
                                  return; // Exit if conversion fails
                                }
                              }

                              if (unitId != null) {
                                await taskCtrl.addTask(task, unitId,
                                    targetValue); // Pass the integer target value

                                final taskId = taskCtrl.taskList.length;
                                taskCtrl.addTaskForDate(DateTime.now(), taskId);
                                await taskCtrl.addUnitToTask(
                                    taskId, unitId.toString());

                                // Clear input fields if needed
                                Get.back();

                                final prefs =
                                await SharedPreferences.getInstance();
                                await prefs.setBool('hasAddedHabit', true);

                                Get.off(() => HabitScreen(),
                                    transition: Transition.fadeIn);
                              } else {
                                Utils.showCustomToast(context,
                                    'Invalid unit selected.'); // Handle the case where unitId is invalid
                              }
                            } else {
                              Utils.showCustomToast(context,
                                  'Please fill in the task and select a unit before adding.');
                            }
                          })
                        ],
                      ),
                      if (isDropdownExpanded)
                        _buildDropdownOptions(setState, context),
                      Positioned(
                        right: 0,
                        top: -8,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child:
                          Icon(Icons.close, size: 28, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildTaskInputField(
      FocusNode taskInputFocusNode, BuildContext context) {
    return GestureDetector(
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
              controller: textCtrl,
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
    );
  }

  Widget _buildUnitDropdown(StateSetter setState, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropdownExpanded = !isDropdownExpanded;
        });
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          taskBackgroundImage(context, 60),
          Padding(
            padding: EdgeInsets.only(left: 14.0),
            child:
            Text(selectedUnit ?? 'Select Unit', style: titleStyle(context)),
          ),
          Positioned(
            right: 14.0,
            child: Icon(
              isDropdownExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownOptions(StateSetter setState, BuildContext context) {
    return Positioned(
      top: 125,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isDropdownExpanded = false;
          });
        },
        child: Stack(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.96,
              child: Image.asset(
                'assets/images/dropdown.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(
              child: ListView(
                padding: EdgeInsets.zero,
                children: units.map((unit) {
                  return Column(
                    children: [
                      _buildDropdownOption(
                          unit['unit_label'],
                          unit['unit_value'],
                          setState,
                          context, (value, valueToShow) {
                        selectedUnit =
                            value; // Assuming unit_label is the string representation of the ID
                        selectedUnitValue =
                            valueToShow; // Set the selected unit value
                        isDropdownExpanded = false;
                      }),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 20, // Space around the divider
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDropdownOption(
      String label,
      String value,
      StateSetter setState,
      BuildContext context,
      Function(String, String) onSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onSelected(label, value); // Pass both label and value
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft, // Aligns text to the left
          child: Text(label, style: titleStyle(context)),
        ),
      ),
    );
  }
}
