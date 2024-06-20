import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class FoodItemCard extends StatelessWidget {
  const FoodItemCard({super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 18),
        height: 164,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white, // Ensure the container has a background color
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(image),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "OMR120",
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                const Text(
                  "Get for OMR 100",
                  style: TextStyle(
                    fontSize: 14,
                    color: kOrange,
                  ),
                ),
                const Text(
                  "A cheeseburger is a\nhamburger with a slice of\nmelted cheese on top of...",
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  children: [
                    const Text(
                      "FREE DELIVERY",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kOrange,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 32,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kOrange,
                      ),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
