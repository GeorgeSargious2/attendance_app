import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyCheckboxTheme {
  MyCheckboxTheme._();

  // -- Customized Checkbox Theme
  static CheckboxThemeData lightCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorsManager.white;
      } else {
        return ColorsManager.white;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorsManager.main;
      } else {
        return ColorsManager.transparent;
      }
    }),
  );

  // -- Customized Checkbox Theme
  static CheckboxThemeData darkCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorsManager.black;
      } else {
        return ColorsManager.white;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorsManager.main;
      } else {
        return ColorsManager.transparent;
      }
    }),
  );
}
