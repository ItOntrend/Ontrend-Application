import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class ItemViewPage extends StatefulWidget {
  const ItemViewPage({super.key});

  @override
  State<ItemViewPage> createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
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
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 321.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/image/mango_shake_image_big.png",
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      10,
                    ),
                    bottomRight: Radius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: const BoxDecoration(
                      color: kWhite,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_outlined),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mango shake",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      "OMR 200",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kOrange,
                      ),
                    ),
                    kWidth20,
                    Text(
                      "OMR 250",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: kGrey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 15,
                      allowHalfRating: true,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: kGreen,
                      ),
                      initialRating: 4.5,
                    ),
                    kWidth20,
                    const Text(
                      "4.5",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 39,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  height: 99.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kGrey,
                    ),
                    borderRadius: BorderRadius.circular(
                      21,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Icecream",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "SlicedMango",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Mango Smoothy",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: 40.h,
                    width: 190.w,
                    decoration: BoxDecoration(
                      color: kGreen,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: _decrementCount,
                          icon: const Icon(Icons.remove),
                          color: _itemCount == 0
                              ? kGrey
                              : kWhite, // Gray out if count is 0
                        ),
                        Text(
                          "$_itemCount",
                          style: const TextStyle(
                            color: kWhite,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                          onPressed: _incrementCount,
                          icon: const Icon(Icons.add),
                          color: kWhite,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
