import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BottomNavBarThemeManager {
  BottomNavBarThemeManager._();
  static BottomNavigationBarThemeData lightBottomNavBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: ColorsManager.transparent,
    // elevation: 8.0,
  );

  static BottomNavigationBarThemeData darkNavBarTheme =
      lightBottomNavBarTheme.copyWith();
}
