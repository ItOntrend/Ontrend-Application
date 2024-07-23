import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class SShimmerEffect extends StatelessWidget {
  const SShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.color,
      this.radius = 15});
  final double width, height, radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color ?? (Colors.white),
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
