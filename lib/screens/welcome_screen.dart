import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goalsync/screens/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/task_controller.dart';
import 'habit_screen.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; // Import the Neumorphic package

class WelcomeScreen extends StatelessWidget {
  final TaskController taskCtrl = Get.put(TaskController());
  final TextEditingController textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  _showAddHabitBottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the content
                  children: [
                    Text(
                      'Add Habit',
                      style: neumorphicButtonTextStyle(context), // Use custom text style
                    ),
                    SizedBox(width: 2), // Space between text and icon
                    Icon(
                      Icons.add,
                      color: neumorphicButtonTextStyle(context).color, // Match icon color to text
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddHabitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Adjust the radius as needed
      ),
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Match the radius here
            child: Neumorphic(
              style: neumorphicBottomSheetStyle(context), // Apply neumorphic style here
              child: Container(
                height: 350,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Add Habit',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Use neumorphicTextFormField here
                    neumorphicTextFormField(context, textCtrl),
                    SizedBox(height: 60),
                    Center(
                      child: SizedBox(
                        width: 140,
                        child: NeumorphicButton(
                          style: neumorphicButtonStyle(context, isSelected: false),
                          onPressed: () {
                            _addTask(context);
                          },
                          child: Center(
                            child: Text(
                              'Add',
                              style: neumorphicButtonTextStyle(context), // Use custom text style
                            ),
                          ),
                        ),
                      ),
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

  Future<void> _addTask(BuildContext context) async {
    final taskName = textCtrl.text.trim();
    if (taskName.isNotEmpty) {
      await taskCtrl.addTask(taskName);
      textCtrl.clear();
      Navigator.pop(context);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasAddedHabit', true);
      Get.to(HabitScreen(), transition: Transition.fadeIn);
    }
  }
}
