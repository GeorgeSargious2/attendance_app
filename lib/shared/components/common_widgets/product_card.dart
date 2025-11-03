// import 'package:e_commerce/core/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../helpers.dart/spacing.dart';

// class ProductCard extends StatelessWidget {
//   final String name;
//   final double price;
//   final double? originalPrice; // Optional: For showing discounts
//   final String imageUrl;
//   final VoidCallback onTap;
//   final VoidCallback? onFavoriteTap; // Optional: For favorite button
//   final bool isFavorite; // Optional: State of favorite button
//   final bool isNetworkImage; // Flag for image source

//   const ProductCard({
//     super.key,
//     required this.name,
//     required this.price,
//     required this.imageUrl,
//     required this.onTap,
//     this.originalPrice,
//     this.onFavoriteTap,
//     this.isFavorite = false,
//     this.isNetworkImage = false, // Default to local asset
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final hasDiscount = originalPrice != null && originalPrice! > price;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 160.w, // Fixed width for horizontal list card
//         margin: EdgeInsets.only(right: 12.w), // Spacing between cards
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image with optional Favorite Button
//             Stack(
//               children: [
//                 Container(
//                   height: 200.h, // Height of the image container
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: ColorsManager.lightGrey, // Placeholder background
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: ClipRRect( // Clip image to rounded corners
//                     borderRadius: BorderRadius.circular(12.r),
//                     child: isNetworkImage
//                         ? Image.network(
//                             imageUrl,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) => const Center(
//                               child: Icon(Icons.image_not_supported_outlined, color: ColorsManager.grey, size: 40),
//                             ),
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return const Center(child: CircularProgressIndicator(strokeWidth: 2, color: ColorsManager.main));
//                             },
//                           )
//                         : Image.asset(
//                             imageUrl,
//                             fit: BoxFit.cover,
//                              errorBuilder: (context, error, stackTrace) => const Center(
//                               child: Icon(Icons.broken_image_outlined, color: ColorsManager.grey, size: 40),
//                             ),
//                           ),
//                   ),
//                 ),
//                 // Favorite Icon Button (Optional)
//                 if (onFavoriteTap != null)
//                   Positioned(
//                     top: 8.r,
//                     right: 8.r,
//                     child: InkWell( // Using InkWell for larger tap area and ripple
//                       onTap: onFavoriteTap,
//                       borderRadius: BorderRadius.circular(20.r),
//                       child: Container(
//                         padding: EdgeInsets.all(6.r),
//                         decoration: BoxDecoration(
//                            color: ColorsManager.white.withOpacity(0.8),
//                            shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
//                           color: isFavorite ? ColorsManager.red : ColorsManager.grey,
//                           size: 20.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             verticalSpace(8),

//             // Product Name
//             Text(
//               name,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: ColorsManager.textDark,
//                   fontSize: 14.sp),
//             ),
//             verticalSpace(4),

//             // Price Row (Current Price and Optional Original Price)
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.baseline, // Align text baselines
//               textBaseline: TextBaseline.alphabetic,
//               children: [
//                 Text(
//                   '\$${price.toStringAsFixed(2)}',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: ColorsManager.main, // Use theme color for price
//                       fontSize: 14.sp),
//                 ),
//                 if (hasDiscount) ...[
//                   horizontalSpace(6),
//                   Text(
//                     '\$${originalPrice!.toStringAsFixed(2)}',
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: ColorsManager.grey,
//                       fontSize: 12.sp,
//                       decoration: TextDecoration.lineThrough, // Strikethrough
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }