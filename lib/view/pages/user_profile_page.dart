import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/login_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/my_orders.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/change_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_tile.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final authController = Get.put(AuthController());
  final cartController = Get.find<CartController>();
  final userController = Get.put(UserController());
  final languageController = Get.put(LanguageController());
  final ImagePicker _picker = ImagePicker();

  final List locale = [
    {'name': "ENGLISH", 'locale': const Locale('en', 'US')},
    {'name': "عربي", 'locale': const Locale('ar', 'OM')}
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
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Locale selectedLocale = locale[index]['locale'];
                    languageController.changeLanguage(selectedLocale);
                    updateLanguage(selectedLocale);
                  },
                  child: Text(locale[index]['name']),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      await userController.uploadProfileImage(imageFile);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        leading: const SizedBox(),
        centerTitle: true,
        title: Text("My Profile".tr),
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
            child: Obx(() {
              if (userController.isLoading.value) {
                return const ShimmerCombine();
              } else {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundColor: kGrey.shade300,
                        radius: 92,
                        backgroundImage: userController
                                .profileImageUrl.value.isNotEmpty
                            ? NetworkImage(userController.profileImageUrl.value)
                            : null,
                        child: userController.profileImageUrl.value.isEmpty
                            ? const Center(
                                child: Icon(
                                  Iconsax.user,
                                  size: 70,
                                  color: kBlack,
                                ),
                              )
                            : null,
                      ),
                    ),
                    kHiegth20,
                    Text(
                      "${userController.firstName.value} ${userController.lastName.value}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHiegth15,
                    ChangeTextfield(
                      hintText: "*Name...".tr,
                      initialValue: userController.firstName.value,
                      onChanged: (value) {
                        userController.firstName.value = value;
                        userController.updateUserField('firstName', value);
                      },
                    ),
                    kHiegth20,
                    TextFormField(
                      initialValue: userController.email.value,
                      enabled: false, // Disable editing
                      decoration: InputDecoration(
                        hintText: "*Email...".tr,
                        suffixIcon: null, // No change button needed
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    kHiegth20,
                    ChangeTextfield(
                      hintText: "Nationality".tr,
                      initialValue: userController.nationality.value,
                      onChanged: (value) {
                        userController.nationality.value = value;
                        userController.updateUserField('nationality', value);
                      },
                    ),
                    kHiegth25,
                    MainTile(
                      name: "My Orders".tr,
                      icon: "assets/icons/my_orders_icon.png",
                      onTap: () async {
                        String userId = await LocalStorage.instance
                            .dataFromPrefs(key: HiveKeys.userData);
                        Get.to(MyOrders(userId: userId));
                      },
                    ),
                    kHiegth25,
                    MainTile(
                      name: "Delete Account".tr,
                      icon: "assets/icons/help_icon.png",
                      onTap: () async {
                        await _showDeleteAccountConfirmationDialog(context);
                      },
                    ),
                    kHiegth25,
                    MainTile(
                      name: "Contact Us".tr,
                      icon: "assets/icons/call_icon.png",
                      onTap: () {
                        whatsapp();
                      },
                    ),
                    kHiegth25,
                    MainTile(
                      name: "Log Out".tr,
                      icon: "assets/icons/power_icon.png",
                      onTap: () async {
                        print("Logging out...");
                        await _showLogoutConfirmationDialog(context);
                      },
                    ),
                    kHiegth30,
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kWhite,
          title: Text('LogOut ?'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logOut?'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel'.tr,
                style: const TextStyle(color: kBlack),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Log Out'.tr,
                  style: const TextStyle(color: kDarkOrange)),
              onPressed: () async {
                await authController.onLogOut();
                Navigator.of(context).pop();
                Get.offAll(() => LoginPage());
              },
            ),
          ],
        );
      },
    );
  }

 Future<void> _showDeleteAccountConfirmationDialog(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kWhite,
          title: Text('Delete Account?'.tr),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'
                  .tr),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr, style: const TextStyle(color: kBlack)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child:
                  Text('Delete'.tr, style: const TextStyle(color: kDarkOrange)),
              onPressed: () async {
                Navigator.of(context).pop();
                _showPointsWarningDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPointsWarningDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kWhite,
          title: Text('Warning'.tr),
          content: Text(
              'Deleting your account will also remove all your points. Do you wish to continue?'
                  .tr),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr, style: const TextStyle(color: kBlack)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes, Delete'.tr,
                  style: const TextStyle(color: kDarkOrange)),
              onPressed: () async {
                try {
                  await authController.deleteAccount(context);
                  Navigator.of(context).pop();
                  Get.offAll(() => LoginPage());
                } catch (e) {
                  print("Error deleting account: $e");
                  Get.snackbar(
                    'Error'.tr,
                    'An error occurred while deleting your account. Please try again.'
                        .tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }


  whatsapp() async {
    String contact = "+968-98710707";
    String text = 'Hello, Ontrend Support, i need assistance with';
    String androidUrl = "whatsapp://send?phone=$contact&text=$text";
    String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch (e) {
      print('object');
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }
}

class ShimmerProfileCard extends StatelessWidget {
  const ShimmerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 200.h,
        width: 200.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kWhite,
        ),
      ),
    );
  }
}

class ShimmerItems extends StatelessWidget {
  const ShimmerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        height: 60.h,
      ),
    );
  }
}

class ShimmerCombine extends StatelessWidget {
  const ShimmerCombine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShimmerProfileCard(),
        kHiegth20,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return const ShimmerItems();
          },
        ),
      ],
    );
  }
}
