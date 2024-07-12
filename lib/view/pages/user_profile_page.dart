import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/change_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.fetchUserData();
    });

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
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
                    ),
                  ),
                ),
                kHiegth20,
                Obx(() {
                  return Text(
                    "${userController.firstName.value}  ${userController.lastName.value}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
                kHiegth15,
                Obx(() {
                  return ChangeTextfield(
                    hintText: "*Name...",
                    initialValue: userController.firstName.value,
                  );
                }),
                kHiegth20,
                Obx(() {
                  return ChangeTextfield(
                    hintText: "*Email...",
                    initialValue: userController.email.value,
                  );
                }),
                kHiegth20,
                Obx(() {
                  return ChangeTextfield(
                    hintText: "Nationality",
                    initialValue: userController.nationality.value,
                  );
                }),
                kHiegth25,
                const MainTile(
                  name: "My Orders",
                  icon: "assets/icons/my_orders_icon.png",
                ),
                kHiegth25,
                const MainTile(
                  name: "Help",
                  icon: "assets/icons/help_icon.png",
                ),
                kHiegth25,
                GestureDetector(
                  onTap: () async{
                    const whatsappUrl = "https://wa.me/+968-98710707";   // Replace with your WhatsApp number
                    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                      await launchUrl(Uri.parse(whatsappUrl));
                    } else {
                      // Handle the case where the URL could not be launched
                      print('Could not launch $whatsappUrl');
                    }
                  },
                  child: const MainTile(
                    name: "Contact Us",
                    icon: "assets/icons/call_icon.png",
                  ),
                ),
                kHiegth25,
                GestureDetector(
                  onTap: () async {
                    await authController.onLogOut();
                    Get.back();
                  },
                  child: const MainTile(
                    name: "Log Out",
                    icon: "assets/icons/power_icon.png",
                  ),
                ),
                kHiegth140,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
