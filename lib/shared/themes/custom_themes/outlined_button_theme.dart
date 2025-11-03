import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/size.dart';
import 'text_theme.dart';

class OutlinedButtonThemeManager {
  OutlinedButtonThemeManager._();

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    // elevation: 0,
    foregroundColor: ColorsManager.bckg,
    side: const BorderSide(color: ColorsManager.grey),
    textStyle: TextThemeManager.lightTextTheme.labelLarge,
    // padding: const EdgeInsets.symmetric(
    //   vertical: 15,
    // ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonCircularRadius)),
  ));

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    // elevation: 0,
    foregroundColor: ColorsManager.bckg,
    side: const BorderSide(color: ColorsManager.grey),
    textStyle: TextThemeManager.lightTextTheme.labelLarge,
    // padding: const EdgeInsets.symmetric(
    //   vertical: 15,
    // ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonCircularRadius)),
  ));
}
