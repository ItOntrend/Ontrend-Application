import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/groceries_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';

class Vegetable extends StatelessWidget {
  const Vegetable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Search bar
                const TextfieldWithMic(
                  hintText: "Vegetables, fruits...",
                ),
                kHiegth15,
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => Get.off(() => GroceriesPage()),
                        child: Icon(Icons.arrow_back)),
                    kWidth30,
                    const TwoTextHeading(heading: "Fresh Vegetables"),
                  ],
                ),
                kHiegth20,
                GestureDetector(
                  onTap: () {
                    //Get.to(
                    // const ProfilePage(),
                    //);
                  },
                  child: ExploreCard(
                    image: "assets/image/pk_store_image.png",
                    tabIndex: 3,
                    onTap: () {},
                    name: 'PK Store',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
