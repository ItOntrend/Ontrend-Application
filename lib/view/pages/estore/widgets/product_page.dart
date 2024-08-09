import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/estore/widgets/product_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class ProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Samsung Galaxy Z 5G AI Smartphone",
      "price": "OMR 352",
      "rating": 3.5,
      "imageUrl": "https://example.com/samsung.jpg",
    },
    {
      "name": "Redmi 13C",
      "price": "OMR 352",
      "rating": 3.5,
      "imageUrl": "https://example.com/redmi.jpg",
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextfieldWithMic(
                hintText: "Home Appliances, Electronics, Books...".tr,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.arrow_back),
                  kWidth10,
                  OneTextHeading(heading: "Mobile Phone"),
                ],
              ),
              kHiegth25,
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    200, // Adjust height based on your needs
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Since it's inside a SingleChildScrollView
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 17,
                    crossAxisSpacing: 17,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return ProductCard(product: product);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
