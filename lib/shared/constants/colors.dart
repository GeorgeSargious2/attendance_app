import 'package:flutter/material.dart';

class ColorsManager {
  ColorsManager._();
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color main = Colors.blue;
  static Color mainOpacity = Colors.blue.withValues(alpha: 0.2);
  static const Color grey = Colors.grey;
  static Color grey100 = Colors.grey[100]!;
  static Color greyOpacity = Colors.grey.withValues(alpha: 0.3);

  static Color whiteOpacity = Colors.white.withOpacity(0.5);
  static const Color bckg = Colors.white;
  static const Color textDark = Color(0xFF1F2937);
  static const Color textLight = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color borderGrey = Color(0xFFE5E7EB);
  static const Color transparent = Colors.transparent;
  static const Color red = Color.fromARGB(255, 210, 51, 51);
  static const Color green = Color(0xFF22C55E);
  static const Color orange = Color(0xFFF97316);
  static const Color second = Color.fromARGB(255, 42, 100, 166);
}
