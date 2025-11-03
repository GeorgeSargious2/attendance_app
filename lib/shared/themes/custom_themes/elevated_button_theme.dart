import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/size.dart';
import 'text_theme.dart';

// class ElevetedButtonThemeManager {
//   ElevetedButtonThemeManager._();
//   static final ButtonStyle _baseStyle = ElevatedButton.styleFrom(
//       minimumSize: Size(double.infinity, 52.h), // Default minimum size
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r) // Use ScreenUtil for radius
//       ),
//       padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w), // Use ScreenUtil for padding
//       textStyle: TextThemeManager.lightTextTheme.labelLarge?.copyWith(
//         fontWeight: FontWeight.w600,
//         fontSize: 16.sp, // Use ScreenUtil for font size
//       ),
//       elevation: 0, // No elevation based on mockups
//       // Define colors using WidgetStateProperty for different states
//       foregroundColor: WidgetStateProperty.resolveWith((states) {
//           if (states.contains(WidgetState.disabled)) {
//             return ColorsManager.white.withOpacity(0.7);
//           }
//           return ColorsManager.white; // Default text color
//       }),
//       backgroundColor: WidgetStateProperty.resolveWith((states) {
//           if (states.contains(WidgetState.disabled)) {
//              return ColorsManager.main.withOpacity(0.5); // Dimmed main color when disabled
//           }
//           return ColorsManager.main; // Main theme color
//       }),
//        overlayColor: WidgetStateProperty.resolveWith<Color?>(
//           (Set<WidgetState> states) {
//             if (states.contains(WidgetState.pressed)) {
//               return ColorsManager.white.withOpacity(0.1); // Slight white overlay on press
//             }
//             return null; // Defer to the default
//           },
//        ),
//        shadowColor: Colors.transparent, // No shadow
//        surfaceTintColor: Colors.transparent, // No tint
//   );

//   // -- Light Theme (using the base style)
//   static final lightElevatedButtonTheme = ElevatedButtonThemeData(style: _baseStyle);

//   // -- Dark Theme (can customize further if needed, otherwise uses base)
//   static final darkElevatedButtonTheme = ElevatedButtonThemeData(
//     style: _baseStyle.copyWith(
//       // Example customization for dark theme if needed
//       // backgroundColor: WidgetStateProperty.resolveWith((states) {
//       //   if (states.contains(WidgetState.disabled)) {
//       //     return ColorsManager.grey; // Use a different disabled color for dark theme
//       //   }
//       //   return ColorsManager.main; // Keep main color or change if needed
//       // }),
//     )
//   );
// }

class ElevetedButtonThemeManager {
  ElevetedButtonThemeManager._();

  // -- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        // maximumSize: const Size(double.infinity, 52),
        // minimumSize: Size.infinite *0.4,
        // elevation: 0,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.main,
        disabledForegroundColor: ColorsManager.white,
        disabledBackgroundColor: ColorsManager.grey,
        side: const BorderSide(color: ColorsManager.transparent),
        // padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: TextThemeManager.lightTextTheme.labelLarge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonCircularRadius))),
  );

  // -- Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        // elevation: 0,
        foregroundColor: ColorsManager.black,
        backgroundColor: ColorsManager.main,
        disabledForegroundColor: ColorsManager.white,
        disabledBackgroundColor: ColorsManager.grey,
        side: const BorderSide(color: ColorsManager.transparent),
        // padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: TextThemeManager.darkTextTheme.labelLarge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonCircularRadius))),
  );
}
