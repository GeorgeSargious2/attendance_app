import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyChipTheme {
  MyChipTheme._();

  // --Light
  static ChipThemeData lightChipThemeData = const ChipThemeData(
    disabledColor: ColorsManager.grey,
    labelStyle: TextStyle(color: ColorsManager.bckg),
    selectedColor: ColorsManager.main,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: ColorsManager.white,
  );

  // --Dark
  static ChipThemeData darkChipThemeData = const ChipThemeData(
    disabledColor: ColorsManager.grey,
    labelStyle: TextStyle(color: ColorsManager.white),
    selectedColor: ColorsManager.main,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: ColorsManager.white,
  );
}
