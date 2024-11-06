import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goalsync/service/settings.dart';
import '../screens/theme.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';//add this


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/img_2.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xFFF5F5FA) // Light theme background color
                : Color(0xFF3E3E3E), // Dark theme background color
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 140),
              _buildNeumorphicButton(
                context,
                buttonText: 'About',
                onPressed: () {
                  Navigator.pop(context);
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
                  Navigator.pop(context);
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
        style: neumorphicButtonStyle(context, isSelected: false),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.symmetric(vertical: 12),
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
