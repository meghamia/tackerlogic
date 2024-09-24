import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(background: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
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
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF333333), // Default button color
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);
//
// final ThemeData darkTheme = ThemeData(
//   primaryColor: Colors.black12,
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.dark(background: Colors.black12),
//   scaffoldBackgroundColor: Colors.grey.shade800,
//   cardColor: Colors.grey.shade800,
//   appBarTheme: AppBarTheme(
//     backgroundColor: Colors.grey.shade800,
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
// );
NeumorphicStyle neumorphicButtonStyle(BuildContext context, {required bool isSelected}) {
  return NeumorphicStyle(
    color: Color(0xFF333333), // Background color: #333333
    depth: isSelected ? 6 : 6,
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Color(0xFF1E1E1E), // Box shadow: 12px 12px 24px 0px #1E1E1E
    shadowLightColor: Color(0xFF3E3E3E), // Box shadow: -12px -12px 24px 0px #3E3E3E
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)), // Add rounded corners

  );
}

//
// NeumorphicStyle neumorphicCheckboxStyle(BuildContext context, {required bool isSelected}) {
//   return NeumorphicStyle(
//     color: Color(0xFF333333), // Background color: #333333
//     depth: isSelected ? 6 : 6,
//     lightSource: LightSource.topLeft,
//     shadowDarkColor: Color(0xFF1E1E1E), // Box shadow
//     shadowLightColor: Color(0xFF3E3E3E), // Box shadow
//     shape: NeumorphicShape.convex, // Use flat shape for a square checkbox
//   );
// }


TextStyle neumorphicButtonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge!.copyWith(
    color: Colors.white, // Change text color to white for better contrast
    fontSize: 16, // You can adjust the font size as needed
    fontWeight: FontWeight.bold, // Optional: set to bold for emphasis
  );
}





NeumorphicStyle neumorphicBottomSheetStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Color(0xFF2E2E2E),
    intensity: 0.8,
    lightSource: LightSource.top,
    shadowDarkColor: Color(0xFF1E1E1E), // Box shadow: 12px 12px 24px 0px #1E1E1E
    shadowLightColor: Color(0xFF3E3E3E), // Box shadow: -12px -12px 24px 0px #3E3E3E
    shape: NeumorphicShape.convex,
  );
}


NeumorphicStyle neumorphicTextFieldStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Color(0xFF3E3E3E), // Upper background color
    depth: 0,
    intensity: 0.6,

    lightSource: LightSource.top,
    shadowDarkColor: Color(0xFF1E1E1E),
    shadowLightColor: Color(0xFF3E3E3E), // Shadow from the top
    shape: NeumorphicShape.flat, // Keep it flat to enhance the inner shadow
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(11), // Circular radius for all sides
    ),
  );
}


Widget neumorphicTextFormField(BuildContext context, TextEditingController controller) {
  return Center(
      child: Container(
      width: 310, // Width: 310px
      height: 55, // Height: 55px
      child: Neumorphic(
        style: neumorphicTextFieldStyle(context), // Apply the neumorphic style
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter Text',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11), // Match border-radius
              borderSide: BorderSide.none, // Remove border
            ),
            filled: true,
            fillColor: Color(0xFF3C3C3C), // Mixed color (adjust as needed)
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintStyle: TextStyle(color: Colors.grey[400]), // Optional: hint color
          ),
        ),
      ),
    ),
  );
}


NeumorphicStyle listTileStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Color(0xFF3E3E3E), // Background color: #333333
    depth: 9,
    intensity: 0.18,
    lightSource: LightSource.left, // Adjust light source
    shadowDarkColor: Color(0xFF1E1E1E), // Dark shadow for more contrast
    shadowLightColor: Color(0xFF4E4E4E), // Lighter shadow color for contrast
    shape: NeumorphicShape.convex,

    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(3)),

  );
}



TextStyle getIconButtonStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge!.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,

  );
}








NeumorphicStyle getDrawerButtonStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).cardColor,
    depth: -10,
    intensity: 0.8,
    lightSource: LightSource.bottomRight,
    shadowLightColor: Theme.of(context).highlightColor,
    shadowDarkColor: Theme.of(context).shadowColor,
    shape: NeumorphicShape.convex,
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

NeumorphicStyle neumorphicGraphContainerStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).cardColor,
    depth: 10,
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Theme.of(context).shadowColor,
    shadowLightColor: Theme.of(context).highlightColor,
    shape: NeumorphicShape.convex,

    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(20))), // Border radius

  );
}

NeumorphicStyle getCalendarContainerStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Theme.of(context).cardColor,
    depth: 10,
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: Theme.of(context).shadowColor,
    shadowLightColor: Theme.of(context).highlightColor,
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(20))), // Border radius

  );


}


// Method to create neumorphic style for the drawer background
NeumorphicStyle neumorphicDrawerStyle(BuildContext context) {
  return NeumorphicStyle(
    color: Color(0xFF333333), // Background color
    depth: 6,
    intensity: 0.8,
    lightSource: LightSource.topRight,
    shadowDarkColor: Color(0xFF1E1E1E), // Dark shadow
    shadowLightColor: Color(0xFF3E3E3E), // Light shadow
    shape: NeumorphicShape.convex, // Change shape as needed
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.zero), // Use BorderRadius.zero for rectangular shape
  );
}
