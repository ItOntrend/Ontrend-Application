import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/firebase_options.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/init_services.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (context, _) {
          return GetMaterialApp(
            initialBinding: BindingsBuilder(() {
              Get.put(UserController());
            }),
            debugShowCheckedModeBanner: false,
            title: 'OnTrend App',
            theme: ThemeData(),
            home: FlutterSplashScreen(
              duration: const Duration(milliseconds: 3000),
              backgroundColor: kWhite,
              splashScreenBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 351.h,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/image/splash_screen_image.png",
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "100% SAFE & SECURE",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kHiegth50,
                ],
              ),
              nextScreen: LoginPage(),
            ),
          );
        });
  }
}
