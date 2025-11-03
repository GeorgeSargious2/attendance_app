import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../helpers.dart/spacing.dart';

class CategoryChip extends StatelessWidget {
  final String name;
  final String iconUrl; // Can be local asset path or network URL
  final VoidCallback onTap;
  final bool isNetworkImage; // Flag to differentiate asset/network

  const CategoryChip({
    super.key,
    required this.name,
    required this.iconUrl,
    required this.onTap,
    this.isNetworkImage = false, // Default to local asset
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w), // Spacing between chips
        child: Column(
          mainAxisSize: MainAxisSize.min, // Take minimum vertical space
          children: [
            Container(
              width: 60.w, // Diameter of the circle
              height: 60.h,
              padding: EdgeInsets.all(
                  12.r), // Padding inside the circle for the icon
              decoration: const BoxDecoration(
                color:
                    ColorsManager.lightGrey, // Background color of the circle
                shape: BoxShape.circle,
              ),
              child: isNetworkImage
                  ? Image.network(
                      iconUrl,
                      fit: BoxFit.contain,
                      color: ColorsManager.textDark, // Optional: Icon color
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.error_outline,
                          color: ColorsManager.grey),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                          color: ColorsManager.main,
                        ));
                      },
                    )
                  : Image.asset(
                      // Assuming local asset if not network
                      iconUrl,
                      fit: BoxFit.contain,
                      color: ColorsManager.textDark, // Optional: Icon color
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.error_outline,
                          color: ColorsManager.grey),
                    ),
            ),
            verticalSpace(8),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: ColorsManager.textDark,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
