// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeController extends GetxController {
//   RxBool isDark = true.obs; // Start with true for dark theme
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTheme();
//   }
//
//   Future<void> loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     isDark.value = prefs.getBool('isDark') ?? true; // Default to dark theme
//     Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
//   }
//
//   Future<void> changeTheme() async {
//     isDark.value = !isDark.value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isDark', isDark.value);
//     Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
//   }
// }





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // RxBool to hold the current theme state
  RxBool isDark = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // Load the saved theme preference when the controller initializes
  }

  // Method to load the theme preference from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Default to dark theme if the value is not found
    isDark.value = prefs.getBool('isDark') ?? true;
    // Change the theme mode based on the loaded preference
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Method to toggle the theme
  Future<void> changeTheme() async {
    isDark.value = !isDark.value; // Toggle the theme state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark.value); // Save the new preference
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light); // Apply the new theme
  }
}

