import 'package:flutter/material.dart';
import 'package:attendance_app/shared/constants/colors.dart';

class TextThemeManager {
  TextThemeManager._();

  // -- Customized Light Text Theme
  // to use it "Theme.of(context).textTheme.bodyMedium"
  static TextTheme lightTextTheme = TextTheme(
// =========== Head 20_white =======================================================
    headlineLarge: const TextStyle().copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white),

// =========== Head 16_white =======================================================
    headlineMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white),

// =========== Head 20_white =======================================================
    headlineSmall: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: ColorsManager.main),

// =========== body 14_white =======================================================
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white),

// =========== body 14_main =======================================================
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: ColorsManager.main),

// =========== body 10_white =======================================================
    bodySmall: const TextStyle().copyWith(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white),

// =========== Buttons 13_white =======================================================
    labelLarge: const TextStyle().copyWith(
        fontSize: 13.0, fontWeight: FontWeight.w700, color: ColorsManager.grey),

// =========== TextField 12_error =======================================================
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: ColorsManager.red),

// =========== TextField 12_grey =======================================================
    labelSmall: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: ColorsManager.grey),
  );

  // -- Customized Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
// =========== Head 20_white =======================================================
    headlineLarge: const TextStyle().copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white),

// =========== Head 16_white =======================================================
    headlineMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white),

// =========== Head 20_main =======================================================
    headlineSmall: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: ColorsManager.main),

// =========== body 14_white =======================================================
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white),

// =========== body 14_main =======================================================
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: ColorsManager.main),

// =========== body 10_white =======================================================
    bodySmall: const TextStyle().copyWith(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white),

// =========== Buttons 13_white =======================================================
    labelLarge: const TextStyle().copyWith(
        fontSize: 13.0,
        fontWeight: FontWeight.w700,
        color: ColorsManager.white),

// =========== TextField 12_error =======================================================
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: ColorsManager.red),

// =========== TextField 12_grey =======================================================
    labelSmall: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: ColorsManager.grey),
  );
}
