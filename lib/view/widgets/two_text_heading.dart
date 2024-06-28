import 'package:flutter/material.dart';

class TwoTextHeading extends StatelessWidget {
  const TwoTextHeading({super.key, required this.heading});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // const Text(
        //   "View All",
        //   style: TextStyle(fontSize: 18, color: Colors.black45),
        // ), 
      ],
    );
  }
}
