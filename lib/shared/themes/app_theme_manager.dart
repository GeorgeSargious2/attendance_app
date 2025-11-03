import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/bottomnavbar_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/navbar_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemeManager {
  AppThemeManager._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: ColorsManager.main,
    scaffoldBackgroundColor: ColorsManager.white,
    navigationBarTheme: NavBarThemeManager.lightNavBarTheme,
    bottomNavigationBarTheme: BottomNavBarThemeManager.lightBottomNavBarTheme,
    // bottomAppBarTheme: ,
    bottomSheetTheme: MyBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: MyCheckboxTheme.lightCheckboxThemeData,
    chipTheme: MyChipTheme.lightChipThemeData,
    colorScheme: ColorScheme.light(
      primary: ColorsManager.main,
      secondary: ColorsManager.main.withOpacity(0.8),
      surface: ColorsManager.white,
      background: ColorsManager.white,
      error: ColorsManager.red,
      onPrimary: ColorsManager.white,
      onSecondary: ColorsManager.white,
      onSurface: ColorsManager.textDark,
      onBackground: ColorsManager.textDark,
      onError: ColorsManager.white,
      brightness: Brightness.light,
      surfaceVariant: ColorsManager.lightGrey,
      outline: ColorsManager.borderGrey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle:
          TextStyle(height: 0.8, fontSize: 10.sp, color: ColorsManager.red),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      hintStyle: TextStyle(
          color: ColorsManager.textLight,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      labelStyle: TextStyle(
          color: ColorsManager.textLight,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      floatingLabelStyle: TextStyle(
          color: ColorsManager.main.withOpacity(0.8),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      filled: true,
      fillColor: ColorsManager.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorsManager.main, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.main,
        disabledForegroundColor: ColorsManager.white.withOpacity(0.7),
        disabledBackgroundColor: ColorsManager.main.withOpacity(0.5),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        textStyle: TextStyle(
            fontSize: 16.sp,
            color: ColorsManager.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsManager.textDark,
        side: BorderSide(color: ColorsManager.borderGrey, width: 1.5),
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        textStyle: TextStyle(
            fontSize: 16.sp,
            color: ColorsManager.textDark,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.textDark,
          fontFamily: 'Poppins'),
      bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textDark,
          fontFamily: 'Poppins'),
      bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textDark,
          fontFamily: 'Poppins'),
      bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textLight,
          fontFamily: 'Poppins'),
      labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: ColorsManager.main,
          fontFamily: 'Poppins'),
    ).apply(
      fontFamily: 'Poppins',
      bodyColor: ColorsManager.textDark,
      displayColor: ColorsManager.textDark,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsManager.white,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: ColorsManager.textDark, size: 24.sp),
      titleTextStyle: TextStyle(
          color: ColorsManager.textDark,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins'),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: ColorsManager.main,
    scaffoldBackgroundColor: const Color(0xFF121212),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.main,
        disabledForegroundColor: ColorsManager.black.withOpacity(0.5),
        disabledBackgroundColor: ColorsManager.main.withOpacity(0.4),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        textStyle: TextStyle(
            fontSize: 16.sp,
            color: ColorsManager.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle:
          TextStyle(height: 0.8, fontSize: 10.sp, color: ColorsManager.red),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      hintStyle: TextStyle(
          color: ColorsManager.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      labelStyle: TextStyle(
          color: ColorsManager.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      floatingLabelStyle: TextStyle(
          color: ColorsManager.main.withOpacity(0.8),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorsManager.main, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeManager.darkOutlinedButtonTheme,
    navigationBarTheme: NavBarThemeManager.darkNavBarTheme,
    bottomSheetTheme: MyBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: MyCheckboxTheme.darkCheckboxThemeData,
    chipTheme: MyChipTheme.darkChipThemeData,
    colorScheme: ColorScheme.dark(
      primary: ColorsManager.main,
      secondary: ColorsManager.main.withOpacity(0.8),
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      error: ColorsManager.red,
      onPrimary: ColorsManager.white,
      onSecondary: ColorsManager.white,
      onSurface: ColorsManager.white.withOpacity(0.87),
      onBackground: ColorsManager.white.withOpacity(0.87),
      onError: ColorsManager.black,
      brightness: Brightness.dark,
      surfaceVariant: const Color(0xFF2A2A2A),
      outline: ColorsManager.grey,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.white.withOpacity(0.87),
          fontFamily: 'Poppins'),
      bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.white.withOpacity(0.87),
          fontFamily: 'Poppins'),
      bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.white.withOpacity(0.87),
          fontFamily: 'Poppins'),
      bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.grey,
          fontFamily: 'Poppins'),
      labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: ColorsManager.main,
          fontFamily: 'Poppins'),
    ).apply(
      fontFamily: 'Poppins',
      bodyColor: ColorsManager.white.withOpacity(0.87),
      displayColor: ColorsManager.white.withOpacity(0.87),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: const Color(0xFF121212),
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
          color: ColorsManager.white.withOpacity(0.87), size: 24.sp),
      titleTextStyle: TextStyle(
          color: ColorsManager.white.withOpacity(0.87),
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins'),
    ),
  );
}
