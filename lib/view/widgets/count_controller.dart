import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class CountController extends StatefulWidget {
  final Function() onIncrement;
  final Function() onDecrement;
  final int count;

  const CountController({
    Key? key,
    required this.onIncrement,
    required this.onDecrement,
    required this.count,
  }) : super(key: key);

  @override
  _CountControllerState createState() => _CountControllerState();
}

class _CountControllerState extends State<CountController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          padding: const EdgeInsets.only(bottom: 1, top: 3),
          icon: const Icon(
            Icons.remove,
            size: 18,
            color: kWhite,
          ),
          onPressed: widget.onDecrement,
        ),
        Text(
          widget.count.toString(),
          style: const TextStyle(
            color: kWhite,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: IconButton(
            padding: const EdgeInsets.only(bottom: 1, top: 3),
            icon: const Icon(
              Icons.add,
              size: 18,
              color: kWhite,
            ),
            onPressed: widget.onIncrement,
          ),
        ),
      ],
    );
  }
}
