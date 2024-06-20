import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryName1,
    required this.categoryImage1,
    required this.categoryName,
    required this.categoryImage,
  });

  final String categoryName;
  final String categoryImage;
  final String categoryName1;
  final String categoryImage1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          categoryImage,
        ),
        Text(
          categoryName,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        kHiegth30,
        Image.asset(
          categoryImage1,
        ),
        Text(
          categoryName1,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
