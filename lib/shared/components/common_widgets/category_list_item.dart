import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class CategoryListItem extends StatelessWidget {
  final String imageUrl; // Use NetworkImage or AssetImage based on source
  final String categoryName;
  final VoidCallback onTap;

  const CategoryListItem({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorsManager.lightGrey, // Use light grey background
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w, // Adjust size as needed
              height: 60.h,
              decoration: BoxDecoration(
                color: ColorsManager.white, // White background for image frame
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  // Or AssetImage
                  imageUrl,
                  fit: BoxFit.contain, // Or BoxFit.cover
                  // Add error builder for network images
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported_outlined,
                    color: ColorsManager.grey,
                  ),
                  // Add loading builder if desired
                  // loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(child: CircularProgressIndicator(
                  //      value: loadingProgress.expectedTotalBytes != null
                  //          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  //          : null,
                  //      strokeWidth: 2,
                  //   ));
                  // },
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                categoryName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: ColorsManager.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Optional: Add a forward arrow icon
            // Icon(
            //   Icons.arrow_forward_ios_rounded,
            //   size: 18.sp,
            //   color: ColorsManager.grey,
            // )
          ],
        ),
      ),
    );
  }
}
