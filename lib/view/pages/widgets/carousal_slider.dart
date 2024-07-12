import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/s_rounded_image.dart';
// Import your controller

class SPromoSliderWidget extends StatelessWidget {
  final GroceryController imageController = Get.put(GroceryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (imageController.imageUrls.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30).copyWith(top: 16),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: imageController.imageUrls.map((url) {
                return SRoundedImageWidget(
                  onPressed: () {},
                  imageUrl: url,
                  width: double.infinity,
                  isnetworkImage: true,
                  borderRadius: 20,
                  applyImageRadius: true,
                );
              }).toList(),
            ),
          ),
        );
      }
    });
  }
}
