import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:goalsync/service/settings.dart';
import '../screens/theme.dart'; // Import the file where getDrawerButtonTextStyle is defined

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack( // Use Stack to layer the image and the buttons
        children: [
          // Background Image
          Image.asset(
            'assets/images/img_2.png', // Updated path to your image asset
            fit: BoxFit.cover, // Make sure the image covers the entire area
            width: double.infinity, // Make image full width
            height: double.infinity, // Make image full height
          ),
          // Content on top of the image
          ListView(
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
                  Get.to(() => MySettings());
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
        ],
      ),
    );
  }

  Widget _buildNeumorphicButton(
      BuildContext context, {
        required String buttonText,
        required VoidCallback onPressed,
      }) {
    return Center(
      child: Neumorphic(
        style: NeumorphicStyle(
          color: Color(0xFF333333), // Background color for the button
          depth: -6, // Set depth for the button
          intensity: 0.8,
          lightSource: LightSource.bottomRight,
          shadowDarkColor: Color(0xFF1E1E1E), // Dark shadow color
          shadowLightColor: Color(0xFF3E3E3E), // Light shadow color
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.zero), // Rectangular shape
        ),
        child: GestureDetector(
          onTap: onPressed, // Handle button tap
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7, // Adjust button width as needed
            padding: EdgeInsets.symmetric(vertical: 16), // Add padding for the button
            child: Center(
              child: Text(
                buttonText,
                style: getDrawerButtonTextStyle(context), // Set button text style
              ),
            ),
          ),
        ),
      ),
    );
  }
}
