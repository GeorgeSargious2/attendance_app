import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import 'text_theme.dart';

class TextFormFieldManager {
  TextFormFieldManager._();

  // highlight-start
  // Helper to create consistent border style
  static OutlineInputBorder _createBorder(Color color, {double width = 1.5}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
      borderSide: BorderSide(width: width, color: color),
    );
  }

  // -- Base Input Decoration Theme --
  static final InputDecorationTheme _baseInputDecorationTheme =
      InputDecorationTheme(
    errorMaxLines: 2,
    // prefixIconColor: ColorsManager.grey, // Set colors per state if needed
    // suffixIconColor: ColorsManager.grey,

    // Default states
    filled: true, // Fields are filled by default
    fillColor: ColorsManager.lightGrey, // Default background color
    contentPadding: EdgeInsets.symmetric(
        vertical: 16.h, horizontal: 20.w), // Use ScreenUtil

    // Text Styles (referencing TextThemeManager)
    labelStyle: TextThemeManager.lightTextTheme.bodyLarge
        ?.copyWith(color: ColorsManager.textLight), // Label style (if used)
    hintStyle: TextThemeManager.lightTextTheme.bodyLarge
        ?.copyWith(color: ColorsManager.textLight), // Hint text style
    errorStyle: TextThemeManager.lightTextTheme.labelMedium?.copyWith(
        color: ColorsManager.red, fontSize: 12.sp), // Error text style
    floatingLabelStyle: TextThemeManager.lightTextTheme.bodyMedium?.copyWith(
        color: ColorsManager.main), // Style when label floats (if used)

    // Border Styles
    border: _createBorder(Colors.transparent,
        width: 0), // No border by default (relies on fill)
    enabledBorder:
        _createBorder(Colors.transparent, width: 0), // No border when enabled
    focusedBorder:
        _createBorder(ColorsManager.main), // Main color border when focused
    errorBorder: _createBorder(ColorsManager.red), // Red border on error
    focusedErrorBorder: _createBorder(ColorsManager.red,
        width: 2), // Thicker red border on focused error
    disabledBorder: _createBorder(ColorsManager.grey.withOpacity(0.2),
        width: 0), // Faded border/fill when disabled (adjust as needed)

    // Ensure consistent height (optional, adjust padding instead if possible)
    // constraints: BoxConstraints.expand(height: 52.h), // Can force height

    // Icon Colors (can be set specifically)
    // prefixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? ColorsManager.main : ColorsManager.grey),
    // suffixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? ColorsManager.main : ColorsManager.grey),
  );

  // -- Light Theme --
  static InputDecorationTheme lightTextFormField = _baseInputDecorationTheme;

  // -- Dark Theme --
  static InputDecorationTheme darkTextFormField = _baseInputDecorationTheme.copyWith(
      // Example customizations for dark theme
      // fillColor: ColorsManager.blackCard, // Darker fill for dark mode
      // hintStyle: TextThemeManager.darkTextTheme.bodyLarge?.copyWith(color: ColorsManager.grey),
      // focusedBorder: _createBorder(ColorsManager.main.withOpacity(0.8)), // Adjust focus color if needed
      // errorStyle: TextThemeManager.darkTextTheme.labelMedium?.copyWith(color: ColorsManager.red.shade300),
      );
  // highlight-end
}

// class TextFormFieldManager {
//   TextFormFieldManager._();

//   static InputDecorationTheme lightTextFormField = InputDecorationTheme(
//     errorMaxLines: 3,
//     prefixIconColor: ColorsManager.grey,
//     suffixIconColor: ColorsManager.grey,
//     // fillColor: MyColors.greyOpacity,
//     // constraints: const BoxConstraints.expand(height: 14.inputFieldHeight),
//     labelStyle: TextThemeManager.lightTextTheme.labelSmall,
//     hintStyle: TextThemeManager.lightTextTheme.labelSmall,
//     errorStyle: TextThemeManager.lightTextTheme.labelMedium,
//     //
//     floatingLabelStyle: TextThemeManager.lightTextTheme.labelSmall,
//     border: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.grey)),
//     enabledBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.grey)),
//     focusedBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.main)),
//     errorBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.red)),
//     focusedErrorBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 2, color: ColorsManager.orange)),
//   );

//   static InputDecorationTheme darkTextFormField = InputDecorationTheme(
//     errorMaxLines: 2,
//     prefixIconColor: ColorsManager.grey,
//     suffixIconColor: ColorsManager.grey,
//     // fillColor: MyColors.greyOpacity,
//     // constraints: const BoxConstraints.expand(height: 14.inputFieldHeight),
//     labelStyle: TextThemeManager.darkTextTheme.labelSmall,
//     hintStyle: TextThemeManager.darkTextTheme.labelSmall,
//     errorStyle: TextThemeManager.darkTextTheme.labelMedium,
//     //
//     floatingLabelStyle: TextThemeManager.darkTextTheme.labelSmall,
//     border: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.grey)),
//     enabledBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.grey)),
//     focusedBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.main)),
//     errorBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 1, color: ColorsManager.red)),
//     focusedErrorBorder: const OutlineInputBorder().copyWith(
//         borderRadius: BorderRadius.circular(buttonCircularRadius),
//         borderSide: const BorderSide(width: 2, color: ColorsManager.orange)),
//   );
// }
