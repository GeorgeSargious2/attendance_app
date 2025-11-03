import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class Loader extends StatelessWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;

  const Loader({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveSize = size?.r ?? 40.r;

    return Center(
      child: SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: CircularProgressIndicator(
          color: color ?? ColorsManager.main,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
