import 'package:flutter/material.dart';

class ShimmerRound extends StatelessWidget {
  const ShimmerRound({super.key, required this.height, required this.width});

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(
          0.2,
        ),
      ),
    );
  }
}
