import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFF5F5FA), // Background color
  ),
  scaffoldBackgroundColor: Color(0xFFF5F5FA), // Background color for scaffolds
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF5F5FA), // AppBar background color
    iconTheme: IconThemeData(
        color: Colors.black), // Change icon color to black for light theme
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF333333), // Default button color
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF333333), // Background color
  appBarTheme: AppBarTheme(
    color: Color(0xFF333333), // AppBar background color
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF333333), // Default button color
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);

NeumorphicStyle neumorphicAppBarStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme ? Color(0xFFF5F5FA) : Color(0xFF3E3E3E),
    depth: 4,
    intensity: 0.7,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme
        ? Color(0xFFBDBDBD)
        : Color(0xFF1E1E1E), // Light or dark shadow
    shadowLightColor:
        isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF3E3E3E), // Lighter shadows
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    )),
  );
}

NeumorphicStyle neumorphicButtonStyle(BuildContext context,
    {required bool isSelected}) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme
        ? Color(0xFFF5F5FA)
        : Color(0xFF3E3E3E), // Light theme background color
    depth: isSelected ? -7 : 7,
    intensity: 0.9,
    lightSource: LightSource.topRight,
    shadowDarkColor: isLightTheme
        ? Color(0xFFBDBDBD)
        : Color(0xFF1E1E1E), // Lighter shadow for light theme
    shadowLightColor: isLightTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF3E3E3E), // Light shadow for light theme
    shape: NeumorphicShape.concave,
    boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12)), // Add rounded corners
  );
}

NeumorphicStyle drawerButtonStyle(BuildContext context,
    {required bool isSelected}) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme
        ? Color(0xFFF5F5FA)
        : Color(0xFF3E3E3E), // Light theme background color
    depth: isSelected ? -7 : 7,
    intensity: 0.9,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme
        ? Color(0xFFBDBDBD)
        : Color(0xFF1E1E1E), // Lighter shadow for light theme
    shadowLightColor: isLightTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF3E3E3E), // Light shadow for light theme
    shape: NeumorphicShape.concave,
    boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12)), // Add rounded corners
  );
}

NeumorphicStyle checkBoxStyle(BuildContext context,
    {required bool isSelected}) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme
        ? Color(0xFFF5F5FA)
        : Color(0xFF3E3E3E), // Light theme background color
    depth: isSelected ? 7 : -7,
    intensity: 0.2,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme
        ? Color(0xFFBDBDBD)
        : Color(0xFF1E1E1E), // Lighter shadow for light theme
    shadowLightColor: isLightTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF3E3E3E), // Light shadow for light theme
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(3)),
  );
}

List<BoxShadow> darkThemeBoxShadows = [
  BoxShadow(
    color: Color(0xFF1E1E1E), // Dark shadow
    offset: Offset(4, 4), // Positive outer shadow
    blurRadius: 8, // Blur outer shadow
    spreadRadius: 0, // Spread outer shadow
  ),
  BoxShadow(
    color: Color(0xFF4D4D4D).withOpacity(0.25),
    offset: Offset(4, 4), // Negative inner shadow
    blurRadius: 2, // Blur  inner shadow
    spreadRadius: 1, // Spread  inner shadow
  ),
  BoxShadow(
    color: Color(0xFF1E1E1E), // Dark shadow
    offset: Offset(10, 10), // Positive  outer shadow
    blurRadius: 10, // Blur  outer shadow
    spreadRadius: 1, // Spread  outer shadow
  ),
  BoxShadow(
    color: Color(0xFF3C3C3C), // Light shadow
    offset: Offset(10, -10), // Negative inner shadow
    blurRadius: 10, // Blur inner shadow
    spreadRadius: 1,
  ),
];

List<BoxShadow> lightThemeBoxShadows = [
  BoxShadow(
    color: Color(0xFFFFFFFF), // Light shadow
    offset: Offset(-10, -10), // Negative outer shadow
    blurRadius: 20, // Blur outer shadow
    spreadRadius: 0, // Spread  outer shadow
  ),
  BoxShadow(
    color: Color(0xFFAAAACC).withOpacity(0.5), // Light shadow
    offset: Offset(10, 10), // Positive inner shadow
    blurRadius: 20, // Blur inner shadow
    spreadRadius: 0, // Spread  inner shadow
  ),
  BoxShadow(
    color:
        Color(0xFFAAAACC).withOpacity(0.25), // Light shadow (with 25% opacity)
    offset: Offset(5, 5), // Positive offset for the shadow
    blurRadius: 10,
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0xFFFFFFFF).withOpacity(0.5),
    offset: Offset(-5, -5),
    blurRadius: 10,
    spreadRadius: 0,
  ),
];

List<BoxShadow> getCurrentThemeBoxShadows(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return isLightTheme ? lightThemeBoxShadows : darkThemeBoxShadows;
}

NeumorphicStyle neumorphicBottomSheetStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F5FA)
        : Color(0xFF2E2E2E),
    intensity: 0.8,
    lightSource: LightSource.top,
    shadowDarkColor: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFFFFFFF).withOpacity(0.4)
        : Color(0xFF1E1E1E),
    shadowLightColor: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFAAAAAC).withOpacity(0.5)
        : Color(0xFF3E3E3E),
    shape: NeumorphicShape.convex,
  );
}

BoxDecoration taskSelectedStyle({required bool isSelected}) {
  Offset offsetDistance = Offset(30, 30); // Distance for the shadow offset
  double blurRadius = 37.0; // Blurriness of the shadow

  return BoxDecoration(
      // color: Color(0xFF3E3E3E), // Neumorphic background color
      //borderRadius: BorderRadius.circular(11), // Rounded corners
      // boxShadow: [
      //   BoxShadow(
      //     color: Color(0xFF1E1E1E).withOpacity(0.9), // Dark shadow
      //     offset: offsetDistance, // Negative offset for inner shadow
      //     blurRadius: blurRadius,
      //     spreadRadius: -10,
      //   ),
      //   BoxShadow(
      //     color: Color(0xFF3E3E3E).withOpacity(0.3), // Light shadow
      //     offset: offsetDistance, // Positive offset for outer shadow
      //     blurRadius: blurRadius,
      //     spreadRadius: -100,
      //   ),
      // ],
      );
}

TextStyle getDrawerButtonTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}

NeumorphicStyle neumorphicToggleButtonStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).cardColor,
    depth: 9,
    intensity: 0.7,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Theme.of(context).shadowColor,
    shadowLightColor: Theme.of(context).highlightColor,
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.circle(),
  );
}

Widget neumorphicGraphContainer(BuildContext context, {required Widget child}) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return Container(
    decoration: BoxDecoration(
      color: isLightTheme
          ? Color(0xFFF5F5FA)
          : Color(0xFF333333), // Background color based on theme
      borderRadius:
          BorderRadius.circular(11), // Same as NeumorphicBoxShape border radius
      boxShadow: isLightTheme
          ? lightThemeBoxShadows
          : darkThemeBoxShadows, // Apply shadows based on theme
    ),
    child: Neumorphic(
      style: NeumorphicStyle(
        color: Colors
            .transparent, // Transparent to see the BoxDecoration background
        depth: 10,
        intensity: 0.2,
        lightSource: LightSource.topLeft,
        shadowDarkColor: isLightTheme ? Color(0xFF1E1E1E) : Color(0xFF1E1E1E),
        shadowLightColor: isLightTheme ? Color(0xFF3E3E3E) : Color(0xFF3E3E3E),
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(11)), // Rounded corners
      ),
      child: child, // Pass child widget here
    ),
  );
}

NeumorphicStyle getCalendarContainerStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme
        ? Color(0xFFF5F5FA)
        : Color(0xFF333333), // Light theme color and dark theme color
    depth: 10,
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme
        ? Color(0xFFBDBDBD)
        : Color(0xFF1E1E1E), // Shadow color based on theme
    shadowLightColor: isLightTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF3E3E3E), // Shadow color based on theme
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.all(Radius.circular(20))), // Border radius
  );
}

TextStyle HeadingStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: isLightTheme ? Colors.black : Colors.white,
    height: 1.2,
  );
}

TextStyle subheadingStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter-Thin-BETA.otf',
    color: isLightTheme ? Colors.black : Colors.white,
    height: 21.78 / 18,
  );
}

TextStyle titleStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter-Thin-BETA.otf',
    color: isLightTheme ? Colors.black : Colors.white,
    height: 26.63 / 22,
  );
}

TextStyle drawerTextStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter-Medium.otf',
    color: isLightTheme ? Colors.black : Colors.white,
    height: 16.94 / 14,
  );
}

Widget taskBackgroundImage(BuildContext context, double height) {
  final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
  final String backgroundImage = isLightTheme
      ? 'assets/images/lightask.png' // Use light theme image
      : 'assets/images/darktask.png'; // Use dark theme image
  return Image.asset(
    backgroundImage,
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget addButton(BuildContext context, VoidCallback onPressed) {
  final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
  final String buttonImage = isLightTheme
      ? 'assets/images/sheetlight.png' // Light theme image
      : 'assets/images/sheetdark.png'; // Dark theme image

  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 100,
      width: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(buttonImage),
          fit: BoxFit.cover, // Ensure the image covers the button area
        ),
      ),
      child: Center(
        child: Text(
          'Add',
          style: titleStyle(context), // Your text style
        ),
      ),
    ),
  );
}


NeumorphicStyle neumorphicDropDown(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F5FA)
        : Color(0xFF2E2E2E),
    intensity: 0.8,
    lightSource: LightSource.top,
    shadowDarkColor: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFFFFFFF).withOpacity(0.4)
        : Color(0xFF1E1E1E),
    shadowLightColor: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFAAAAAC).withOpacity(0.5)
        : Color(0xFF3E3E3E),
    shape: NeumorphicShape.convex,
  );
}
