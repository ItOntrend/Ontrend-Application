import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class AddToCartCard extends StatefulWidget {
  const AddToCartCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.image,
  });

  final String itemName;
  final String itemPrice;
  final String image;

  @override
  State<AddToCartCard> createState() => _AddToCartCardState();
}

class _AddToCartCardState extends State<AddToCartCard> {
  int _itemCount = 0;

  void _incrementCount() {
    setState(() {
      _itemCount++;
    });
  }

  void _decrementCount() {
    if (_itemCount > 0) {
      setState(() {
        _itemCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7).copyWith(
        left: 13,
        right: 7,
      ),
      height: 101.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                widget.itemName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              kHiegth6,
              Text(
                widget.itemPrice,
                style: const TextStyle(
                  color: kOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              kHiegth6,
              Container(
                height: 22.h,
                width: 108.w,
                decoration: BoxDecoration(
                  color: kGreen,
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 1),
                      onPressed: _decrementCount,
                      icon: const Icon(
                        Icons.remove,
                        size: 14,
                      ),
                      color: _itemCount == 0
                          ? kGrey
                          : kWhite, // Gray out if count is 0
                    ),
                    Text(
                      "$_itemCount",
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 1),
                      onPressed: _incrementCount,
                      icon: const Icon(
                        Icons.add,
                        size: 14,
                      ),
                      color: kWhite,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.topRight,
            child: Stack(
              children: [
                Align(
                  child: Image.asset(widget.image),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
