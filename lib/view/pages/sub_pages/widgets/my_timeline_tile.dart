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
    this.indicator,
    required this.isPast,
  });
  final bool isFirst;
  final bool isLast;
  // ignore: prefer_typing_uninitialized_variables
  final child;
  // ignore: prefer_typing_uninitialized_variables
  final indicator;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: 80.w,
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? kTimetilestyleLineColor : Colors.green.shade100,
        ),
        indicatorStyle: IndicatorStyle(
          indicator: indicator,
          iconStyle: IconStyle(
              iconData: Icons.done,
              fontSize: 14,
              color: isPast ? kWhite : Colors.orange.shade100),
          color: isPast ? kDarkOrange : Colors.orange.shade100,
          width: 14,
        ),
        endChild: child,
      ),
    );
  }
}
