import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import 'custom_button.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30.sp,
              color: ColorsManager.red,
            ),
            SizedBox(height: 8.h),
            Text(
              'someThingWentWrong',
              // .tr(context),
              style: TextStyle(
                color: ColorsManager.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              CustomButton(
                label: 'retry',
                // .tr(context),
                onPressed: onRetry!,
                buttonType: ButtonType.outlined,
                // backgroundColor: ColorsManager.lemonGreen,
                borderColor: ColorsManager.second,
                foregroundColor: ColorsManager.second,
                width: 90.w,
                height: 32.h,
                fontSize: 14.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
