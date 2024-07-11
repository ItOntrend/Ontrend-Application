import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/delivery_boy_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/my_timeline_tile.dart';

class AfterOrderPage extends StatelessWidget {
  const AfterOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAll(const NavigationManu()),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    MyTimelineTile(
                      isFirst: false,
                      isLast: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/lottie_animation/pending.gif",
                              height: 128.h,
                              width: 128.w,
                            ),
                            const Text("Order is being prepared",
                                style: kTextStyle14Grey),
                            const Text(
                              "Estimated arrival",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHiegth20,
                            const Text(
                              "10 - 20 minutes",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kHiegth15,
                            kHiegth24,
                            const Text(
                              "Mohammed has arrived at Dominos Pizza on time. If you have any questions, you can reach out to your rider 🛵 ",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff5C5C5C),
                              ),
                            ),
                            kHiegth10,
                            const DeliveryBoyCard(),
                          ],
                        ),
                      ),
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Picked up your order"),
                            const Text("Track your order"),
                            Image.asset(
                              "assets/lottie_animation/on_the_way.gif",
                              height: 128,
                              width: 128,
                            ),
                            Container(
                              height: 32,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text("Click Here")),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: false,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "On delivery",
                              style: kTextStyle14Grey,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Your order from- ",
                                  style: kTextStyle14Grey,
                                ),
                                kWidth10,
                                Container(
                                  height: 21,
                                  width: 27,
                                  decoration: BoxDecoration(
                                    color: kGreen,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                kWidth10,
                                const Text("Vendor Name")
                              ],
                            ),
                            kHiegth24,
                            Container(
                              padding: const EdgeInsets.all(13),
                              height: 325.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: kGrey),
                              ),
                              child: const Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Item Count and Name"),
                                      Spacer(),
                                      Text("Item Price")
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Text("Sub Total"),
                                      Spacer(),
                                      Text("Item Price")
                                    ],
                                  ),
                                  kHiegth10,
                                  Row(
                                    children: [
                                      Text("Discount"),
                                      Spacer(),
                                      Text("Item Price")
                                    ],
                                  ),
                                  kHiegth10,
                                  Row(
                                    children: [
                                      Text("Delivery fee"),
                                      Spacer(),
                                      Text("Item Price")
                                    ],
                                  ),
                                  kHiegth10,
                                  Row(
                                    children: [
                                      Text("Service fee"),
                                      Spacer(),
                                      Text("Item Price")
                                    ],
                                  ),
                                  kHiegth10,
                                  Row(
                                    children: [
                                      Text("Total"),
                                      Spacer(),
                                      Text("Item Price")
                                    ],
                                  ),
                                  kHiegth10,
                                  Row(
                                    children: [
                                      Text("Payment method"),
                                      Spacer(),
                                      Text("Cash")
                                    ],
                                  ),
                                  kHiegth10,
                                  Row(
                                    children: [
                                      Text("Delivery Time"),
                                      Spacer(),
                                      Text("23 Min")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyTimelineTile(
                      isFirst: false,
                      isLast: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Order Placed"),
                            const Text(
                                "Thanks 🙏 for your order check here anytime for updates"),
                            kHiegth10,
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 66,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffFFA4746B),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "You earned 15 points for this order"),
                                      Text("View rewards"),
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/icons/reward_icon_image.png",
                                    height: 35.h,
                                    width: 45.w,
                                  ),
                                ],
                              ),
                            ),
                            kHiegth18,
                            Text(
                              "Deliverying to",
                              style: TextStyle(),
                            ),
                            kHiegth10,
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/address_icon_image.png",
                                  height: 35,
                                  width: 35,
                                ),
                                kWidth15,
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("The Address"),
                                    Text("Phone Number")
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
