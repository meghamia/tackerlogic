import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(background: Colors.white),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    textColor: Colors.black,
    iconColor: Colors.white,
    selectedTileColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.black12,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(background: Colors.black12),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.grey.shade800,
    textColor: Colors.white,
    iconColor: Colors.white,
    selectedTileColor: Colors.grey[800],
  ),
  scaffoldBackgroundColor: Colors.grey.shade800,
  cardColor: Colors.grey.shade800,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

NeumorphicStyle neumorphicButtonStyle(BuildContext context,
    {required bool isSelected}) {
  // Determine the theme brightness
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  final backgroundColor = isLightTheme
      ? (isSelected ? Colors.white : Colors.white)
      : (isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).cardColor);

  final shadowColor = Theme.of(context).shadowColor;
  final highlightColor = Theme.of(context).highlightColor;

  return NeumorphicStyle(
    color: backgroundColor,
    depth: isSelected ? 6 : 6, // Adjust depth for 3D effect, modify as needed
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: shadowColor,
    shadowLightColor: highlightColor,
  );
}

NeumorphicStyle neumorphicBottomSheetStyle(
  BuildContext context,
) {
  return NeumorphicStyle(
    color: Theme.of(context).scaffoldBackgroundColor,
    depth: 10,
    intensity: 0.7,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Theme.of(context).shadowColor,
    shadowLightColor: Theme.of(context).highlightColor,
  );
}

TextStyle getIconButtonStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 18, // Adjust font size as needed
        fontWeight: FontWeight.w400, // Adjust font weight as needed
      );
}

// Neumorphic Style for Drawer Button
NeumorphicStyle getDrawerButtonStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: Theme.of(context).cardColor,
    depth: -10, // Negative depth for inner shadow (concave)
    intensity: 0.8,
    lightSource: LightSource.bottomRight,
    //shadowLightColor: isLightTheme ? const Color(0xE2E2E236) : const Color(0x3E3E3E),
    shadowLightColor: isLightTheme
        ? Colors.white
        : Colors.grey.shade800, // Dark theme shadow color
    shadowDarkColor: isLightTheme
        ? Colors.black12
        : Colors.black26, // Dark theme shadow color

    //shadowDarkColor: isLightTheme ? const Color(0xE2E2E236) : const Color(0x1E1E1E), // Dark theme shadow color
    shape: NeumorphicShape.concave, // Inner shadow (concave) effect
  );
}

// TextStyle for Drawer Button
TextStyle getDrawerButtonTextStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return TextStyle(
    color: isLightTheme ? Colors.black : Colors.white,
    fontSize: 18, // Adjust font size as needed
    fontWeight: FontWeight.w400, // Adjust font weight as needed
  );
}

NeumorphicStyle neumorphicToggleButtonStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme ? Colors.white : Colors.grey.shade800,
    depth: 9, // Depth for toggle button
    intensity: 0.7,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme
        ? Colors.black.withOpacity(0.5)
        : Colors.black.withOpacity(0.7),
    shadowLightColor: isLightTheme
        ? Colors.white.withOpacity(0.3)
        : Colors.grey.shade800.withOpacity(0.5),
    shape: NeumorphicShape.convex, // Convex shape for the toggle button
    boxShape: NeumorphicBoxShape.circle(), // Circle shape for the toggle button
  );
}

NeumorphicStyle neumorphicGraphContainerStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).cardColor, // Use the card color from the theme
    depth: 8,
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Theme.of(context).shadowColor,
    shadowLightColor: Theme.of(context).highlightColor,
  );
}
