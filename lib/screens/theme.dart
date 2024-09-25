// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
//
//
// final ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   colorScheme: ColorScheme.light(background: Color(0xFFF5F5FA)), // Background color
//   scaffoldBackgroundColor: Color(0xFFF5F5FA), // Background color for scaffolds
//   cardColor: Colors.white,
//   appBarTheme: AppBarTheme(
//     backgroundColor: Color(0xFFF5F5FA), // AppBar background color
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
// );
//
//
//
// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: Color(0xFF333333), // Background color
//   appBarTheme: AppBarTheme(
//     color: Color(0xFF333333), // AppBar background color
//     elevation: 0,
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
//   textTheme: TextTheme(
//     bodyText1: TextStyle(color: Colors.white),
//     bodyText2: TextStyle(color: Colors.white),
//     headline6: TextStyle(color: Colors.white),
//   ),
//   buttonTheme: ButtonThemeData(
//     buttonColor: Color(0xFF333333), // Default button color
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//   ),
// );
//
// NeumorphicStyle neumorphicButtonStyle(BuildContext context, {required bool isSelected}) {
//   return NeumorphicStyle(
//
//     color: Color(0xFF3E3E3E), // Neumorphic background color
//     depth: isSelected ? 6 : 6,
//     intensity: 0.5,
//     lightSource: LightSource.topLeft,
//     shadowDarkColor: Color(0xFF1E1E1E), // Box shadow: 12px 12px 24px 0px #1E1E1E
//     shadowLightColor: Color(0xFF3E3E3E), // Box shadow: -12px -12px 24px 0px #3E3E3E
//     shape: NeumorphicShape.convex,
//     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(13)), // Add rounded corners
//   );
// }
//
// // Box shadows for custom decoration
// List<BoxShadow> customBoxShadows = [
//   BoxShadow(
//     color: Color(0xFF1E1E1E), // Dark shadow
//     offset: Offset(4, 4), // Positive offset for the outer shadow
//     blurRadius: 8, // Blur radius for the outer shadow
//     spreadRadius: 0, // Spread radius for the outer shadow
//   ),
//   BoxShadow(
//     color: Color(0xFF4D4D4D).withOpacity(0.25), // Light shadow (with 40% opacity)
//     offset: Offset(4, 4), // Negative offset for the inner shadow
//     blurRadius: 2, // Blur radius for the inner shadow
//     spreadRadius: 1, // Spread radius for the inner shadow
//   ),
//   BoxShadow(
//     color: Color(0xFF1E1E1E), // Dark shadow
//     offset: Offset(10, 10), // Positive offset for the outer shadow
//     blurRadius: 10, // Blur radius for the outer shadow
//     spreadRadius: 1, // Spread radius for the outer shadow
//   ),
//   BoxShadow(
//     color: Color(0xFF3C3C3C), // Light shadow
//     offset: Offset(10, -10), // Negative offset for the inner shadow
//     blurRadius: 10, // Blur radius for the inner shadow
//     spreadRadius: 1, // Spread radius for the inner shadow
//   ),
// ];
//
//
// //
// // NeumorphicStyle neumorphicCheckboxStyle(BuildContext context, {required bool isSelected}) {
// //   return NeumorphicStyle(
// //     color: Color(0xFF333333), // Background color: #333333
// //     depth: isSelected ? 6 : 6,
// //     lightSource: LightSource.topLeft,
// //     shadowDarkColor: Color(0xFF1E1E1E), // Box shadow
// //     shadowLightColor: Color(0xFF3E3E3E), // Box shadow
// //     shape: NeumorphicShape.convex, // Use flat shape for a square checkbox
// //   );
// // }
//
//
// TextStyle neumorphicButtonTextStyle(BuildContext context) {
//   return Theme.of(context).textTheme.bodyLarge!.copyWith(
//     color: Colors.white, // Change text color to white for better contrast
//     fontSize: 16, // You can adjust the font size as needed
//     fontWeight: FontWeight.bold, // Optional: set to bold for emphasis
//   );
// }
//
//
//
//
//
// NeumorphicStyle neumorphicBottomSheetStyle(BuildContext context) {
//   return NeumorphicStyle(
//     color: Color(0xFF2E2E2E),
//     intensity: 0.8,
//     lightSource: LightSource.top,
//     shadowDarkColor: Color(0xFF1E1E1E), // Box shadow: 12px 12px 24px 0px #1E1E1E
//     shadowLightColor: Color(0xFF3E3E3E), // Box shadow: -12px -12px 24px 0px #3E3E3E
//     shape: NeumorphicShape.convex,
//   );
// }
//
//
//
//
// Widget neumorphicTextFormField(BuildContext context, TextEditingController controller) {
//   Offset offsetDistance = Offset(10, 10);
//   double blurRadius = 8.0;
//
//   return Center(
//     child: AnimatedContainer(
//       duration: Duration(milliseconds: 200), // Smooth animation
//       width: 310,
//       height: 55,
//       decoration: BoxDecoration(
//         color: Color(0xFF3E3E3E), // Neumorphic background color
//         borderRadius: BorderRadius.circular(11),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF1E1E1E).withOpacity(0.7), // Dark shadow
//             offset: -offsetDistance, // Negative offset for inner shadow
//             blurRadius: blurRadius,
//             spreadRadius: 1,
//           ),
//           BoxShadow(
//             color: Color(0xFF3E3E3E).withOpacity(0.3), // Light shadow
//             offset: offsetDistance, // Positive offset for outer shadow
//             blurRadius: blurRadius,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: 'Enter Task',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(11),
//             borderSide: BorderSide.none, // Remove border
//           ),
//           filled: true,
//           fillColor: Color(0xFF2C2C2C), // Dark background fill color
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           hintStyle: TextStyle(color: Colors.grey[400]), // Hint text color
//         ),
//       ),
//     ),
//   );
// }
//
// //
// // NeumorphicStyle listTileStyle(BuildContext context) {
// //   return NeumorphicStyle(
// //     color: Color(0xFF3E3E3E), // Background color: #333333
// //     depth: 9,
// //     intensity: 0.18,
// //     lightSource: LightSource.left, // Adjust light source
// //     shadowDarkColor: Color(0xFF1E1E1E), // Dark shadow for more contrast
// //     shadowLightColor: Color(0xFF4E4E4E), // Lighter shadow color for contrast
// //     shape: NeumorphicShape.convex,
// //
// //     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(3)),
// //
// //   );
// // }
//
//
// //
// // TextStyle getIconButtonStyle(BuildContext context) {
// //   return Theme.of(context).textTheme.bodyLarge!.copyWith(
// //     fontSize: 18,
// //     fontWeight: FontWeight.w400,
// //
// //   );
// // }
//
//
//
//
//
// // This widget is similar to NeumorphicTextFormField but only displays inner shadow without any form fields
// BoxDecoration taskSelectedStyle({required bool isSelected}) {
//   Offset offsetDistance = Offset(30, 30); // Distance for the shadow offset
//   double blurRadius = 37.0; // Blurriness of the shadow
//
//   return BoxDecoration(
//    // color: Color(0xFF3E3E3E), // Neumorphic background color
//     //borderRadius: BorderRadius.circular(11), // Rounded corners
//     // boxShadow: [
//     //   BoxShadow(
//     //     color: Color(0xFF1E1E1E).withOpacity(0.9), // Dark shadow
//     //     offset: offsetDistance, // Negative offset for inner shadow
//     //     blurRadius: blurRadius,
//     //     spreadRadius: -10,
//     //   ),
//     //   BoxShadow(
//     //     color: Color(0xFF3E3E3E).withOpacity(0.3), // Light shadow
//     //     offset: offsetDistance, // Positive offset for outer shadow
//     //     blurRadius: blurRadius,
//     //     spreadRadius: -100,
//     //   ),
//     // ],
//   );
// }
//
//
//
//
//
//
//
//
// TextStyle getDrawerButtonTextStyle(BuildContext context) {
//   return TextStyle(
//     color: Theme.of(context).textTheme.bodyLarge?.color,
//     fontSize: 20,
//     fontWeight: FontWeight.w400,
//
//   );
// }
//
// NeumorphicStyle neumorphicToggleButtonStyle(BuildContext context) {
//   return NeumorphicStyle(
//     color: Theme.of(context).cardColor,
//     depth: 9,
//     intensity: 0.7,
//     lightSource: LightSource.topLeft,
//     shadowDarkColor: Theme.of(context).shadowColor,
//     shadowLightColor: Theme.of(context).highlightColor,
//     shape: NeumorphicShape.convex,
//     boxShape: NeumorphicBoxShape.circle(),
//   );
// }
// Widget neumorphicGraphContainer(BuildContext context, {required Widget child}) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Color(0xFF333333), // Background color: #333333
//       borderRadius: BorderRadius.circular(11), // Same as NeumorphicBoxShape border radius
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 30,
//           offset: Offset(28, 28),
//           color: Color(0xFF1E1E1E).withOpacity(0.5), // Shadow color
//         ),
//         BoxShadow(
//           blurRadius: 30,
//           offset: Offset(-18, -18),
//           color: Color(0xFF3E3E3E).withOpacity(0.5), // Shadow color
//         ),
//       ],
//     ),
//     child: Neumorphic(
//       style: NeumorphicStyle(
//         color: Colors.transparent, // Transparent to see the BoxDecoration background
//         depth: 10,
//         intensity: 0.2,
//         lightSource: LightSource.topLeft,
//         shadowDarkColor: Color(0xFF1E1E1E),
//         shadowLightColor: Color(0xFF3E3E3E),
//         shape: NeumorphicShape.convex,
//         boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(11)), // Rounded corners
//       ),
//       child: child, // Pass child widget here
//     ),
//   );
// }
//
//
// NeumorphicStyle getCalendarContainerStyle(BuildContext context) {
//   return NeumorphicStyle(
//     color: Theme.of(context).cardColor,
//     depth: 10,
//     intensity: 0.8,
//     lightSource: LightSource.topLeft,
//     shadowDarkColor: Theme.of(context).shadowColor,
//     shadowLightColor: Theme.of(context).highlightColor,
//     shape: NeumorphicShape.convex,
//     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(20))), // Border radius
//
//   );
//
//
// }
//









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
    iconTheme: IconThemeData(color: Colors.black), // Change icon color to black for light theme
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.black), // Body text color
    bodyText2: TextStyle(color: Colors.black), // Body text color
    headline6: TextStyle(color: Colors.black), // Headline color
    // Add any other text styles you need, like button text or captions
    button: TextStyle(color: Colors.white), // Button text color
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

NeumorphicStyle neumorphicButtonStyle(BuildContext context, {required bool isSelected}) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme ? Color(0xFFF5F5FA) : Color(0xFF3E3E3E), // Light theme background color
    depth: isSelected ? -7 : 7,
    intensity: 0.9,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme ? Color(0xFFBDBDBD) : Color(0xFF1E1E1E), // Lighter shadow for light theme
    shadowLightColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF3E3E3E), // Light shadow for light theme
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(11)), // Add rounded corners
  );
}






NeumorphicStyle checkBoxStyle(BuildContext context, {required bool isSelected}) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme ? Color(0xFFF5F5FA) : Color(0xFF3E3E3E), // Light theme background color
    depth: isSelected ? 7 : 7,
    intensity: 0.9,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme ? Color(0xFFBDBDBD) : Color(0xFF1E1E1E), // Lighter shadow for light theme
    shadowLightColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF3E3E3E), // Light shadow for light theme
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(3)), // Add rounded corners
  );
}


// Box shadows for custom decoration
List<BoxShadow> darkThemeBoxShadows = [
  BoxShadow(
    color: Color(0xFF1E1E1E), // Dark shadow
    offset: Offset(4, 4), // Positive offset for the outer shadow
    blurRadius: 8, // Blur radius for the outer shadow
    spreadRadius: 0, // Spread radius for the outer shadow
  ),
  BoxShadow(
    color: Color(0xFF4D4D4D).withOpacity(0.25), // Light shadow (with 25% opacity)
    offset: Offset(4, 4), // Negative offset for the inner shadow
    blurRadius: 2, // Blur radius for the inner shadow
    spreadRadius: 1, // Spread radius for the inner shadow
  ),
  BoxShadow(
    color: Color(0xFF1E1E1E), // Dark shadow
    offset: Offset(10, 10), // Positive offset for the outer shadow
    blurRadius: 10, // Blur radius for the outer shadow
    spreadRadius: 1, // Spread radius for the outer shadow
  ),
  BoxShadow(
    color: Color(0xFF3C3C3C), // Light shadow
    offset: Offset(10, -10), // Negative offset for the inner shadow
    blurRadius: 10, // Blur radius for the inner shadow
    spreadRadius: 1, // Spread radius for the inner shadow
  ),
];

List<BoxShadow> lightThemeBoxShadows = [
  BoxShadow(
    color: Color(0xFFFFFFFF), // Light shadow
    offset: Offset(-10, -10), // Negative offset for the outer shadow
    blurRadius: 20, // Blur radius for the outer shadow
    spreadRadius: 0, // Spread radius for the outer shadow
  ),
  BoxShadow(
    color: Color(0xFFAAAACC).withOpacity(0.5), // Light shadow (with 50% opacity)
    offset: Offset(10, 10), // Positive offset for the inner shadow
    blurRadius: 20, // Blur radius for the inner shadow
    spreadRadius: 0, // Spread radius for the inner shadow
  ),
  BoxShadow(
    color: Color(0xFFAAAACC).withOpacity(0.25), // Light shadow (with 25% opacity)
    offset: Offset(5, 5), // Positive offset for the shadow
    blurRadius: 10, // Blur radius for the shadow
    spreadRadius: 0, // Spread radius for the shadow
  ),
  BoxShadow(
    color: Color(0xFFFFFFFF).withOpacity(0.5), // Light shadow with opacity
    offset: Offset(-5, -5), // Negative offset for the shadow
    blurRadius: 10, // Blur radius for the shadow
    spreadRadius: 0, // Spread radius for the shadow
  ),
];

// Function to get the appropriate shadows based on the theme
List<BoxShadow> getCurrentThemeBoxShadows(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return isLightTheme ? lightThemeBoxShadows : darkThemeBoxShadows;
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
    color: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F5FA) // Light theme background color
        : Color(0xFF2E2E2E), // Dark theme background color
    intensity: 0.8,
    lightSource: LightSource.top,
    shadowDarkColor: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFFFFFFF).withOpacity(0.4) // Light shadow for light theme
        : Color(0xFF1E1E1E), // Dark shadow for dark theme
    shadowLightColor: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFAAAAAC).withOpacity(0.5) // Light shadow for light theme
        : Color(0xFF3E3E3E), // Light shadow for dark theme
    shape: NeumorphicShape.convex,
  );
}

Widget neumorphicTextFormField(BuildContext context, TextEditingController controller) {
  Offset offsetDistance = Offset(10, 10);
  double blurRadius = 8.0;

  return Center(
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200), // Smooth animation
      width: 310,
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Color(0xFFF5F5FA) // Light theme background color
            : Color(0xFF3E3E3E), // Dark theme background color
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          // Inner shadow for light theme
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xFFFFFFFF).withOpacity(0.5) // Inner shadow color for light theme
                : Colors.transparent, // No inner shadow for dark theme
            offset: Offset(-10, -10), // Negative offset for inner shadow
            blurRadius: blurRadius,
            spreadRadius: 1,
          ),
          // Outer shadow
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xFFAAAAAC).withOpacity(0.5) // Light shadow for light theme
                : Color(0xFF3E3E3E).withOpacity(0.5), // Dark shadow for dark theme
            offset: -offsetDistance, // Positive offset for outer shadow
            blurRadius: blurRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black // Text color for light theme
              : Colors.white, // Text color for dark theme
        ),
        decoration: InputDecoration(
          hintText: 'Enter Task',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide.none, // Remove border
          ),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? Color(0xFFF5F5FA) // Light theme background fill color
              : Color(0xFF2C2C2C), // Dark theme background fill color
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black // Hint text color for light theme
                : Colors.white, // Hint text color for dark theme
          ),
        ),
      ),
    ),
  );
}
//
// NeumorphicStyle listTileStyle(BuildContext context) {
//   return NeumorphicStyle(
//     color: Color(0xFF3E3E3E), // Background color: #333333
//     depth: 9,
//     intensity: 0.18,
//     lightSource: LightSource.left, // Adjust light source
//     shadowDarkColor: Color(0xFF1E1E1E), // Dark shadow for more contrast
//     shadowLightColor: Color(0xFF4E4E4E), // Lighter shadow color for contrast
//     shape: NeumorphicShape.convex,
//
//     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(3)),
//
//   );
// }


//
// TextStyle getIconButtonStyle(BuildContext context) {
//   return Theme.of(context).textTheme.bodyLarge!.copyWith(
//     fontSize: 18,
//     fontWeight: FontWeight.w400,
//
//   );
// }





// This widget is similar to NeumorphicTextFormField but only displays inner shadow without any form fields
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
      color: isLightTheme ? Color(0xFFF5F5FA) : Color(0xFF333333), // Background color based on theme
      borderRadius: BorderRadius.circular(11), // Same as NeumorphicBoxShape border radius
      boxShadow: isLightTheme ? lightThemeBoxShadows : darkThemeBoxShadows, // Apply shadows based on theme
    ),
    child: Neumorphic(
      style: NeumorphicStyle(
        color: Colors.transparent, // Transparent to see the BoxDecoration background
        depth: 10,
        intensity: 0.2,
        lightSource: LightSource.topLeft,
        shadowDarkColor: isLightTheme ? Color(0xFF1E1E1E) : Color(0xFF1E1E1E),
        shadowLightColor: isLightTheme ? Color(0xFF3E3E3E) : Color(0xFF3E3E3E),
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(11)), // Rounded corners
      ),
      child: child, // Pass child widget here
    ),
  );
}
NeumorphicStyle getCalendarContainerStyle(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  return NeumorphicStyle(
    color: isLightTheme ? Color(0xFFF5F5FA) : Color(0xFF333333), // Light theme color and dark theme color
    depth: 10,
    intensity: 0.8,
    lightSource: LightSource.topLeft,
    shadowDarkColor: isLightTheme ? Color(0xFFBDBDBD) : Color(0xFF1E1E1E), // Shadow color based on theme
    shadowLightColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF3E3E3E), // Shadow color based on theme
    shape: NeumorphicShape.convex,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(20))), // Border radius
  );
}


