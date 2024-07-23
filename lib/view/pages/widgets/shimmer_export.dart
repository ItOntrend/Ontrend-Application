import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_skelton.dart';

class ShimmerExport extends StatelessWidget {
  const ShimmerExport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skelton(
          width: double.infinity,
          height: 150.h,
        ),
        kHiegth15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skelton(
              width: 80.w,
            ),
            Skelton(
              width: 120.w,
            ),
          ],
        ),
        kHiegth10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skelton(
              width: 120.w,
            ),
            Skelton(
              width: 80.w,
            )
          ],
        ),
      ],
    );
  }
}