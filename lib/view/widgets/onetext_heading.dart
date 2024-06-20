import 'package:flutter/material.dart';

class OneTextHeading extends StatelessWidget {
  const OneTextHeading({
    super.key,
    required this.heading,
  });
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
