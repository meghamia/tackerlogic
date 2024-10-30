import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';
import '../screens/theme.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    final ThemeData themeData = Theme.of(context);
    final isLightTheme = themeData.brightness == Brightness.light;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Neumorphic(
          style: neumorphicAppBarStyle(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppBar(
              title: Text("Settings",
                style: HeadingStyle(context),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: isLightTheme ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 23),
            Neumorphic(
              style: neumorphicButtonStyle(context, isSelected: false),
              child: ListTile(
                title:  Text('Theme',
                  style: subheadingStyle(context),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    themeController.changeTheme();
                  },
                  child: Obx(() {
                    bool isDark = themeController.isDark.value;
                    return Container(
                      width: 80,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                        border: Border.all(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: Align(
                        alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                        child: Neumorphic(
                          style: neumorphicToggleButtonStyle(context),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                isDark
                                    ? Icons.dark_mode_outlined
                                    : Icons.light_mode_outlined,
                                color: isDark ? Colors.white : Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
