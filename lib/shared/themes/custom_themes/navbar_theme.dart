import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';

class NavBarThemeManager {
  NavBarThemeManager._();
  static NavigationBarThemeData lightNavBarTheme = NavigationBarThemeData(
    height: 80.h,
    backgroundColor: ColorsManager.white,
    indicatorColor: ColorsManager.main.withOpacity(0.1),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      final color = states.contains(WidgetState.selected)
          ? ColorsManager.main
          : ColorsManager.grey;
      return IconThemeData(size: 26.sp, color: color);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      final color = states.contains(WidgetState.selected)
          ? ColorsManager.main
          : ColorsManager.grey;
      return TextStyle(
          fontSize: 12.sp, fontWeight: FontWeight.w500, color: color);
    }),
    elevation: 8.0,
    shadowColor: Colors.black.withOpacity(0.05),
    surfaceTintColor: ColorsManager.transparent,
  );

  static NavigationBarThemeData darkNavBarTheme = lightNavBarTheme.copyWith();
}
