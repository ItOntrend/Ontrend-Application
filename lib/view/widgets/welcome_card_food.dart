import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class WelcomeCardFood extends StatelessWidget {
  const WelcomeCardFood({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 164.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 255, 98, 0),
            const Color.fromARGB(255, 255, 115, 0).withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                "WELCOME TO ONTREND",
                style: GoogleFonts.jost(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              Text(
                "Enjoy free delivery & 50%\nOFF on your first order",
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 6,
            child: Image.asset(
              image,
              width: 143.w,
            ),
          ),
        ],
      ),
    );
  }
}
