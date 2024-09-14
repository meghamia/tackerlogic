import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:tracker/service/settings.dart';
import '../screens/theme.dart'; // Import the file where getDrawerButtonStyle and getDrawerButtonTextStyle are defined

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final drawerBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Drawer(
      child: Container(
        color: drawerBackgroundColor, // Use theme's scaffold background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 140), // Add spacing if needed
            _buildNeumorphicButton(
              context,
              buttonText: 'About',
              onPressed: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            SizedBox(height: 10),
            _buildNeumorphicButton(
              context,
              buttonText: 'Settings',
              onPressed: () {
                Get.to(()=>MySettings());
              },
            ),
            SizedBox(height: 10),
            _buildNeumorphicButton(
              context,
              buttonText: 'Privacy Policy',
              onPressed: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeumorphicButton(
      BuildContext context, {
        required String buttonText,
        required VoidCallback onPressed,
      }) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7, // Adjust button width as needed
        child: Neumorphic(
          style: getDrawerButtonStyle(context),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // To ensure Neumorphic button color is used
              shadowColor: Colors.transparent, // Remove default shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: getDrawerButtonTextStyle(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
