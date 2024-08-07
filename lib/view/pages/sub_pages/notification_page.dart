import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_all_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_ecart_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_food_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_groceries_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          centerTitle: true,
          title: Text("Notification".tr),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                // Set a preferred height for the tab bar container
                height: 30.0,
                decoration: BoxDecoration(
                  color: kTransparent, // Light grey background
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: TabBar(
                  overlayColor: const WidgetStatePropertyAll(kTransparent),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  labelStyle: const TextStyle(color: kWhite),
                  unselectedLabelStyle: const TextStyle(color: kBlack),
                  // indicatorColor: kBlue,
                  dividerColor: kTransparent,
                  isScrollable: false, // Disable scrolling
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: kOrange, // Color based on selection
                    // Light grey border
                  ),
                  labelPadding: EdgeInsets.zero, // Remove default padding
                  tabs: [
                    // Individual tab containers
                    _buildTabItem(
                      text: "All".tr,
                      // Check if selected
                    ),
                    _buildTabItem(
                      text: "Food".tr,
                    ),
                    _buildTabItem(
                      text: "Groceries".tr,
                    ),
                    _buildTabItem(
                      text: "E - Cart".tr,
                    ),
                  ],
                ),
              ),
              kHiegth20,
              const Expanded(
                // Use Expanded to fill remaining space
                child: TabBarView(
                  // Content for each tab
                  children: [
                    NAllBar(),
                    NFoodBar(),
                    NGroceriesBar(),
                    NEcartBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for building tab items
  Widget _buildTabItem({required String text}) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      // height: 40,
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: kGrey,
        ),
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 1, // Ensure text stays on one line
          overflow: TextOverflow.ellipsis, // Handle potential truncation
          // style: TextStyle(
          //   color: isSelected
          //       ? Colors.white
          //       : Colors.black54, // Text color based on selection
          //   fontSize: 14.0, // Adjust font size as needed
          // ),
        ),
      ),
    );
  }
}
