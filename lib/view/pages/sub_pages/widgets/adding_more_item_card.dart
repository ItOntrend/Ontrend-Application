import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class AddingMoreItemCard extends StatelessWidget {
  const AddingMoreItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add more items".tr,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                height: 19.h,
                width: 19.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhite,
                  border: Border.all(
                    color: kGreen,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 12,
                  color: kBlack,
                ),
              ),
            ],
          ),
          kHiegth9,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _showAddRequestDialog(context),
                child: Text(
                  "Add cooking requests".tr,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showAddRequestDialog(context),
                child: Container(
                  height: 19.h,
                  width: 19.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite,
                    border: Border.all(
                      color: kGreen,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 12,
                    color: kBlack,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddRequestDialog(BuildContext context) {
    TextEditingController requestController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kWhite,
          title: Text('Add Cooking Request'.tr),
          content: TextField(
            controller: requestController,
            decoration: InputDecoration(hintText: 'Enter your request here'.tr),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel'.tr,
                style: TextStyle(
                  color: kDarkOrange,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'Add'.tr,
                style: TextStyle(
                  color: kDarkOrange,
                ),
              ),
              onPressed: () {
                // Handle the cooking request here
                String request = requestController.text;
                // Add your logic to handle the request

                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
