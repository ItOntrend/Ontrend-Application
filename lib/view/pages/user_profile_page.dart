import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/my_orders.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/change_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final authController = Get.find<AuthController>();
  final cartController = Get.find<CartController>();
  final userController = Get.find<UserController>();
  final languageController = Get.put(LanguageController());
  final List locale = [
    {'name': "ENGLISH", 'locale': Locale('en', 'US')},
    {'name': "عربي", 'locale': Locale('ar', 'OM')}
  ];
  updateLanguage(Locale locale) {
    print("Updating language to ${locale.languageCode}");
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
                  onTap: () {
                    Locale selectedLocale = locale[index]['locale'];
                    updateLanguage(selectedLocale);
                    languageController.changeLanguage(selectedLocale);
                    //updateLanguage(locale[index]['locale']);
                  },
                  child: Text(locale[index]['name']),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.orange,
                );
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
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
        title: Text(
          "My Profile".tr,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/icons/translate_icon.png",
              height: 24,
            ),
            onPressed: () {
              buildDialog(context);
            },
          ),
          const SizedBox(width: 16),
        ],
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
                    "${userController.firstName.value} ${userController.lastName.value}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
                kHiegth15,
                Obx(() {
                  return ChangeTextfield(
                      hintText: "*Name...".tr,
                      initialValue: userController.firstName.value
                      // userDetail['firstName'] ?? '',
                      );
                }),
                kHiegth20,
                Obx(() {
                  return ChangeTextfield(
                      hintText: "*Email...".tr,
                      initialValue: userController.email.value);
                }),
                kHiegth20,
                Obx(() {
                  return ChangeTextfield(
                    hintText: "Nationality".tr,
                    initialValue: userController.nationality.value,
                  );
                }),
                kHiegth25,
                MainTile(
                  name: "My Orders".tr,
                  icon: "assets/icons/my_orders_icon.png",
                  onTap: () async {
                    String userId = await LocalStorage.instance
                        .dataFromPrefs(key: HiveKeys.userData);
                    Get.to(MyOrders(
                      userId: userId,
                    ));
                  },
                ),
                kHiegth25,
                MainTile(
                  name: "Help".tr,
                  icon: "assets/icons/help_icon.png",
                ),
                kHiegth25,
                MainTile(
                  name: "Contact Us".tr,
                  icon: "assets/icons/call_icon.png",
                  onTap: () {
                    launchWhatsApp(
                      phone:
                          '96898710707', // Ensure correct format without dashes
                      message: 'Hello! This is a message from my app.',
                    ).catchError((e) {
                      print('Error launching WhatsApp: $e');
                      // Optionally, show an error message to the user
                    });
                  },
                ),
                kHiegth25,
                MainTile(
                  name: "Log Out".tr,
                  icon: "assets/icons/power_icon.png",
                  onTap: () async {
                    print("Logging out...");
                    await authController.onLogOut();
                    Get.back();
                  },
                ),
                kHiegth140,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> launchWhatsApp(
      {required String message, required String phone}) async {
    final Uri whatsappUrl = Uri.parse(
        "whatsapp://send?phone=$phone&text=${Uri.encodeFull(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      print('Could not launch $whatsappUrl');
    }
  }
}
