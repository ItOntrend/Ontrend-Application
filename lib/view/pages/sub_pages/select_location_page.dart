import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "Select Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              enabled: false,
              decoration: InputDecoration(
                prefixIcon: Image.asset("assets/icons/search_icon.png"),
                hintText: "Search for area, street name...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ),
            kHiegth20,
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/small_location_orange_icon.svg",
                ),
                kWidth15,
                const Text(
                  "Use my current location",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            kHiegth10,
            kDiver10,
            kHiegth20,
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/small_add_orange_icon.svg",
                ),
                kWidth15,
                const Text(
                  "Add  new address",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            kHiegth10,
            kDiver10,
            kHiegth28,
            const Text(
              "SAVED ADDRESSES",
              style: TextStyle(
                color: kGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            kHiegth20,
            ListTile(
              leading: SvgPicture.asset(
                "assets/svg/small_location_grey_icon.svg",
              ),
              title: Text(
                "My Office",
              ),
              subtitle: Text("#314 ABC Building, Oman . 13m"),
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/svg/small_location_grey_icon.svg",
              ),
              title: Text("My Home"),
              subtitle: Text("#314 ABC Building, Oman . 13m"),
            ),
          ],
        ),
      ),
    );
  }
}
