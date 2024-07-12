import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          "Search",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child:
                  TextfieldWithMic(hintText: "Biryani, Burger, Ice Cream..."),
            ),
            kHiegth20,
            Container(
              padding: const EdgeInsets.all(16),
              height: 144,
              decoration: BoxDecoration(
                  color: kLiteBackground,
                  border: Border.all(color: kBorderLiteBlack)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Resently searched",
                    style: kTextStyle14Grey,
                  ),
                  kHiegth20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 31.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kBorderLiteBlack)),
                        child: const Center(
                          child: Text(
                            "Dominos Pizza",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 31.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kBorderLiteBlack)),
                        child: const Center(
                          child: Text(
                            "Dominos Pizza",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 31.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kBorderLiteBlack)),
                        child: const Center(
                          child: Text(
                            "Dominos Pizza",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHiegth18,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 31.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kBorderLiteBlack)),
                        child: const Center(
                          child: Text(
                            "Dominos Pizza",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 31.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kBorderLiteBlack)),
                        child: const Center(
                          child: Text(
                            "Dominos Pizza",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 31.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kBorderLiteBlack)),
                        child: const Center(
                          child: Text(
                            "Dominos Pizza",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            kHiegth20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kHiegth20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                      CategoryCard(
                          categoryName: "Burger",
                          categoryImage:
                              "https://images.ctfassets.net/9tka4b3550oc/1FQSRLVXt2Q1lvXXkOyW6U/f306561ef7bfc5ab7c84a739a46d3629/Food_09.png?q=75&w=1280",
                          onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
