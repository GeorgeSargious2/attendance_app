import 'package:flutter/widgets.dart';

// TO USE IT:
// context.pop();
// context.pushNamed(Routes.homeScreen);

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

// to use it "'text'.isNullOrEmpty()"
extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

// to use it "[].isNullOrEmpty()"
extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension CorrectedTimeWithAmPm on DateTime {
  String get correctedHour {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return hour12 > 9 ? "$hour12" : "0$hour12";
  }

  String get correctedMinute {
    return minute > 9 ? "$minute" : "0$minute";
  }

  String get amPm {
    return hour >= 12 ? "PM" : "AM";
  }

  String get formattedTime {
    return "$correctedHour:$correctedMinute $amPm";
  }
}
