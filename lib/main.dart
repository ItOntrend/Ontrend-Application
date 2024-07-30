import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/navigation_controller.dart';
import 'package:ontrend_food_and_e_commerce/firebase_options.dart';
import 'package:ontrend_food_and_e_commerce/local_strings.dart';
import 'package:ontrend_food_and_e_commerce/utils/init_services.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initServices();
  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);
  await LocalStorage.instance.initHive();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  String? savedLanguageCode = prefs.getString('language_code');
  Locale initialLocale = Locale('en', 'US'); // Default locale

  // Set the initial locale based on saved language code
  if (savedLanguageCode != null) {
    // Handle both language-only and language-country cases
    if (savedLanguageCode == 'ar') {
      initialLocale = Locale('ar', 'OM'); // Default country code for Arabic
    } else if (savedLanguageCode == 'en') {
      initialLocale = Locale('en', 'US'); // Default country code for English
    }
  }
  Get.put(NavigationController());
  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OnTrend App',
          theme: ThemeData(),
          home: const SplashPage(),
          translations: LocalStrings(),
          locale: initialLocale,
          fallbackLocale: const Locale('en', 'US'), // Fallback locale
        );
      },
    );
  }
}
