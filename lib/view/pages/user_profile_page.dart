import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/change_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_tile.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();
  final List locale = [
    {'name': "ENGLISH", 'locale': Locale('en', 'US')},
    {'name': "عربي", 'locale': Locale('ar', 'OM')}
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose a language'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => updateLanguage(locale[index]['locale']),
                        child: Text(locale[index]['name']));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

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
        title: const Text(
          "My Profile",
        ),
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
                    initialValue: "${userController.firstName.value}"
                    // userDetail['firstName'] ?? '',
                  );
                }),
                kHiegth20,
                Obx(() {
                  return ChangeTextfield(
                    hintText: "*Email...",
                    initialValue: "${userController.email.value}"
                  );
                }),
                kHiegth20,
                Obx(() {
                  return ChangeTextfield(
                    hintText: "Nationality",
                    initialValue: "${userController.nationality.value}",
                  );
                }),
                kHiegth25,
                MainTile(
                  name: "My Orders".tr,
                  icon: "assets/icons/my_orders_icon.png",
                ),
                kHiegth25,
                MainTile(
                  name: "Help".tr,
                  icon: "assets/icons/help_icon.png",
                ),
                kHiegth25,
                const MainTile(
                  name: "Contact Us",
                  icon: "assets/icons/call_icon.png",
                ),
                kHiegth25,
                GestureDetector(
                  onTap: () async {
                    await authController.onLogOut();
                    Get.back();
                  },
                  child: MainTile(
                    name: "Log Out".tr,
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
