import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/best_seller_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/firebase_options.dart';
import 'package:ontrend_food_and_e_commerce/utils/init_services.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initServices();
  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);
  // Initialize controllers
  // Get.put(BestSellerController());
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
              // initialBinding: BindingsBuilder(() {
              //   Get.put(UserController());
              // }),
              debugShowCheckedModeBanner: false,
              title: 'OnTrend App',
              theme: ThemeData(),
              home: const SplashPage());
        });
  }
}
