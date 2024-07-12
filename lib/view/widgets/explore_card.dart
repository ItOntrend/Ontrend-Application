import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class ExploreCard extends StatefulWidget {
  const ExploreCard({
    Key? key,
    required this.name,
    this.locationCity,
    this.image,
    this.tabIndex,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String? locationCity;
  final String? image;
  final int? tabIndex;
  final VoidCallback? onTap;

  @override
  _ExploreCardState createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  late bool _isOnline; // Initialize as late and not directly to true

  @override
  void initState() {
    super.initState();
    _isOnline = true; // Initialize _isOnline here
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    } as void Function(List<ConnectivityResult> event)?);

    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        height: 286.h,
        width: 383.w,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(1, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            image != null && image!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      image!,
                      height: 163.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 163.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        'No image has uploaded',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ).copyWith(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style:  TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text("Salala"),
                      Image.asset("assets/image/small_location_image.png")
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 4),
                      //   height: 29.h,
                      //   width: 63.w,
                      //   decoration: BoxDecoration(
                      //     color: kGreen,
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: const Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "4.2",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: kWhite,
                      //         ),
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         size: 20,
                      //         color: kWhite,
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  kHiegth20,
                  const Row(
                    children: [
                      // const Text(
                      //   "Pizza, Pastas, Desserts",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //   ),
                      // ),
                      // const Spacer(),
                      // const Text("Salala"),
                      // kWidth6,
                      // Image.asset("assets/image/small_location_image.png")
                    ],
                  ),
                  kHiegth6, // Note: Ensure these constants are correctly defined
                   Text(
                    "6.8 km",
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
