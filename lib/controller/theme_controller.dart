import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDark = true.obs; // Start with true for dark theme

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDark') ?? true; // Default to dark theme
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> changeTheme() async {
    isDark.value = !isDark.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
