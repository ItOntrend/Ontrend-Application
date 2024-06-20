import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_tile.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Profile",
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: kGrey.shade300,
                radius: 92,
                child: const Center(
                    child: Icon(
                  Iconsax.user,
                  size: 70,
                  color: kBlack,
                )),
              ),
              kHiegth20,
              const Text("Mohammed Abdullah"),
              kHiegth15,
              const Text("@UserId498"),
              kHiegth25,
              const MainTile(
                name: "My Orders",
                icon: "assets/icons/my_orders_icon.png",
              ),
              kHiegth25,
              const MainTile(
                name: "Personal Details",
                icon: "assets/icons/personal_details_icon.png",
              ),
              kHiegth25,
              const MainTile(
                name: "Settings",
                icon: "assets/icons/settings_icon.png",
              ),
              kHiegth25,
              const MainTile(
                name: "Log Out",
                icon: "assets/icons/power_icon.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
