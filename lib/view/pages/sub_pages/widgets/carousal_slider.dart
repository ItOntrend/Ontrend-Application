import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/s_rounded_image.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_skelton.dart';
import 'package:shimmer/shimmer.dart';
import 'video_widget.dart';
import 'video_playback_controller.dart'; // Import your VideoPlaybackController

class SPromoSliderWidget extends StatelessWidget {
  SPromoSliderWidget({super.key});

  final GroceryController imageController = Get.put(GroceryController());
  final VideoPlaybackController videoPlaybackController = Get.put(VideoPlaybackController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (imageController.imageUrls.isEmpty) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Skelton(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 150.h,
              );
            },
          ),
        );
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16).copyWith(top: 16),
            child: Obx(() {
              return CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: !videoPlaybackController.isVideoPlaying.value,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: imageController.imageUrls.map((media) {
                  return media.contains('.mp4')
                      ? VideoWidget(
                          videoUrl: media,
                          videoPlaybackController: videoPlaybackController,
                        )
                      : SRoundedImageWidget(
                          onPressed: () {},
                          imageUrl: media,
                          width: double.infinity,
                          isnetworkImage: true,
                          borderRadius: 20,
                          applyImageRadius: true,
                          fit: BoxFit.cover,
                        );
                }).toList(),
              );
            }),
          ),
        );
      }
    });
  }
}
