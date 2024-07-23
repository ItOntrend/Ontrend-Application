import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_skelton.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_round.dart';

class ShimmerCetegory extends StatelessWidget {
  const ShimmerCetegory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerRound(height: 80.h, width: 80.w),
        kHiegth10,
        Skelton(width: 60.w)
      ],
    );
  }
}
