import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.categoryImage,
    required this.onTap,
  });

  final String categoryName;
  final String categoryImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Log the category image URL
    print('Category Image URL: $categoryImage');

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: CachedNetworkImage(
                height: 80.h,
                width: 80.w,
                imageUrl: categoryImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
