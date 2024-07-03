import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

List<String> options = ['Option 1', 'Option 2'];

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  String currentOption = options[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: const Text(
          "Payment Options",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ).copyWith(
            top: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Credit & Debit cards",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kBorderLiteBlack,
                ),
              ),
              kHiegth20,
              Flexible(
                child: Container(
                  height: 146.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: kGrey.shade100,
                    border: Border.all(
                      color: kGrey,
                    ),
                  ),
                  child: Column(
                    children: [
                      kHiegth6,
                      ListTile(
                        leading: Container(
                          margin: const EdgeInsets.only(right: 20),
                          height: 36.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: kGrey,
                            ),
                          ),
                          child: Image.asset(
                            "assets/image/visa_image.png",
                          ),
                        ),
                        title: const Text(
                          "Slicy   ......6083",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Radio(
                          activeColor: const Color.fromARGB(255, 3, 34, 59),
                          value: options[0],
                          groupValue: currentOption,
                          onChanged: (value) {
                            setState(() {
                              currentOption = value.toString();
                            });
                          },
                        ),
                      ),
                      kDiver,
                      ListTile(
                        visualDensity: const VisualDensity(
                          vertical: -4,
                        ),
                        leading: Container(
                          margin: EdgeInsets.only(left: 14.w, right: 40.w),
                          height: 27.h,
                          width: 29.w,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(
                              color: kGrey,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/small_add_orange_icon.svg",
                              height: 12,
                              width: 12,
                            ),
                          ),
                        ),
                        title: const Text(
                          "Add New Card",
                          style: TextStyle(
                            color: kOrange,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          "Save any pay via cards",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: kBorderLiteBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kHiegth20,
              Text(
                "More Payment Option",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kBorderLiteBlack,
                ),
              ),
              kHiegth20,
              Container(
                height: 69,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kGrey.shade100,
                  border: Border.all(
                    color: kBorderLiteBlack,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Center(
                  child: ListTile(
                    leading: Container(
                      margin: const EdgeInsets.only(right: 20),
                      height: 36.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: kGrey,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/cash_on_delivery.png",
                        height: 22.h,
                        width: 32.w,
                      ),
                    ),
                    title: const Text(
                      "Pay on Delivery",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "Pay in cash or pay in  online",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: kBorderLiteBlack,
                      ),
                    ),
                    trailing: Radio(
                      activeColor: const Color.fromARGB(255, 3, 34, 59),
                      value: options[1],
                      groupValue: currentOption,
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
