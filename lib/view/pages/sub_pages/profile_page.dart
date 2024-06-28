import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/View/widgets/profile_card.dart';
import 'package:ontrend_food_and_e_commerce/View/widgets/tabbar_one_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/first_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/fourth_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/second_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/third_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.initialTabIndex});

  final int? initialTabIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: initialTabIndex!,
      child: Scaffold(
        backgroundColor: kWhite,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset("assets/image/account_banner.png"),
                  ),
                  Positioned(
                    left: 12,
                    top: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                  Positioned(
                    left: 50,
                    child: Image.asset("assets/image/big_pizza.png"),
                  ),
                  const Positioned(
                    child: ProfileCard(),
                  ),
                ],
              ),
              kHiegth20,
              const TabBar(
                dividerColor: kTransparent,
                indicator: BoxDecoration(
                  color: kTransparent,
                ),
                labelColor: kOrange,
                indicatorColor: kOrange,
                isScrollable: true,
                tabs: [
                  TabBarOneCard(tabname: "40% Offer"),
                  TabBarOneCard(tabname: "20% Offer"),
                  TabBarOneCard(tabname: "Bestseller"),
                  TabBarOneCard(tabname: "Pizza"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // 40% offer
                    FirstBar(),
                    // 20% Offer
                    SecondBar(),
                    // Bestseller
                    ThirdBar(),
                    // Pizza
                    FourthBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
