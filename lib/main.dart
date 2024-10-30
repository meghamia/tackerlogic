import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/task_controller.dart';
import 'controller/theme_controller.dart';
import 'screens/welcome_screen.dart';
import 'screens/habit_screen.dart';
import 'screens/theme.dart'; // Import your theme file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskController()); // Initialize TaskController
  Get.put(ThemeController()); // Initialize ThemeController

  final prefs = await SharedPreferences.getInstance();
  final hasAddedHabit = prefs.getBool('hasAddedHabit') ?? false;

  runApp(MyApp(hasAddedHabit: hasAddedHabit));
}

class MyApp extends StatelessWidget {
  final bool hasAddedHabit;

  MyApp({required this.hasAddedHabit});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light, // Control theme mode
     home: hasAddedHabit ? HabitScreen() : WelcomeScreen(),
     //home: WelcomeScreen(),
    );
  }
}
