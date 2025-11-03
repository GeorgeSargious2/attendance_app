import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attendance_app/shared/constants/colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final String iconAsset;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.onPressed,
    this.backgroundColor =
        Colors.transparent, // Default to transparent for outlined look
    this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 52.h),
        backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: foregroundColor ?? ColorsManager.textDark,
        side: BorderSide(
            color: borderColor ?? ColorsManager.borderGrey, width: 1.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        padding: EdgeInsets.symmetric(
            vertical: 0.h, horizontal: 20.w), // Adjust padding
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return (foregroundColor ?? ColorsManager.textDark)
                  .withOpacity(0.05);
            }
            return null; // Defer to the default
          },
        ),
      ),
      child: Stack(
        // Use Stack to center text and place icon
        alignment: Alignment.center,
        children: [
          Align(
            // Icon aligned to the left
            alignment: Alignment.centerLeft,
            child: iconAsset.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(iconAsset, height: 24.h, width: 24.w)
                : Image.asset(iconAsset, height: 24.h, width: 24.w),
          ),
          Text(
            // Text centered
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: foregroundColor ?? ColorsManager.textDark),
          ),
        ],
      ),
    );
  }
}
