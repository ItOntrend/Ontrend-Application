import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.child,
    // required this.isPast,
  });
  final bool isFirst;
  final bool isLast;
  // ignore: prefer_typing_uninitialized_variables
  final child;
  // final bool isPast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: const LineStyle(
          color: kTimetilestyleLineColor,
        ),
        indicatorStyle: const IndicatorStyle(
          color: kDarkOrange,
          width: 14,
        ),
        endChild: child,
      ),
    );
  }
}
