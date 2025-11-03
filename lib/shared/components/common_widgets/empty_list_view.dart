import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class EmptyListView extends StatelessWidget {
  final IconData icon;
  final String titleKey;
  final String messageKey;

  const EmptyListView({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.messageKey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60.sp,
              color: ColorsManager.white,
            ),
            SizedBox(height: 8.h),
            Text(
              titleKey,
              // titleKey.tr(context),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            Text(
              messageKey,
              // messageKey.tr(context),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
