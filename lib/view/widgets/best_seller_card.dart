import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class BestSellerCard extends StatefulWidget {
  final String imagePath;
  final int price;
  final String vendor;
  final String name;
  final VoidCallback onTap;

  const BestSellerCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.onTap,
    required this.price,
    required this.vendor,
  });

  @override
  _BestSellerCardState createState() => _BestSellerCardState();
}

class _BestSellerCardState extends State<BestSellerCard> {
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final ConnectivityResult connectivityResult =
        (await Connectivity().checkConnectivity()) as ConnectivityResult;
    setState(() {
      _isOnline = connectivityResult != ConnectivityResult.none;
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() {
            _isOnline = result != ConnectivityResult.none;
          });
        } as void Function(List<ConnectivityResult> event)?);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 30),
        height: 180.h,
        width: 186.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(2, 2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                left: 0.5,
                top: 0.5,
                right: 0.5,
                child: _isOnline
                    ? Image.network(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 50,
                              color: kGrey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'No Internet Connection',
                              style: TextStyle(
                                fontSize: 14,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8)
                      .copyWith(bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kHiegth6,
                      Text(
                        '${widget.price}.000',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kOrange,
                        ),
                      ),
                      kHiegth6,
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBlack,
                        ),
                      ),
                      Text(
                        widget.vendor,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
