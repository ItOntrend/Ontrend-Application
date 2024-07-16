import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/history_my_order.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/ongoing_my_order.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/sheduled_my_order.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          centerTitle: true,
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
                height: 40.h,
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
                    borderRadius: BorderRadius.circular(10),
                    color: kOrange, // Color based on selection
                    // Light grey border
                  ),
                  labelPadding: EdgeInsets.zero, // Remove default padding
                  tabs: [
                    // Individual tab containers
                    _buildTabItem(
                      text: "Ongoing".tr,
                    ),
                    _buildTabItem(
                      text: "History",
                      // Check if selected
                    ),

                    _buildTabItem(
                      text: "Sheduled".tr,
                    ),
                  ],
                ),
              ),
              kHiegth20,
              Expanded(
                // Use Expanded to fill remaining space
                child: TabBarView(
                  // Content for each tab
                  children: [
                    
                    OngoingMyOrder(userId: userId,),
                    HistoryMyOrder(
                      userId: userId,
                    ),
                    SheduledMyOrder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 50.h,
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
