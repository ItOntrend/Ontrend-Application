import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class AddingMoreItemCard extends StatefulWidget {
  final String addedBy;
  const AddingMoreItemCard({super.key, required this.addedBy});

  @override
  _AddingMoreItemCardState createState() => _AddingMoreItemCardState();
}

class _AddingMoreItemCardState extends State<AddingMoreItemCard> {
  List<String> requests = [];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => ProfilePage(
                  userId: widget.addedBy,
                  type: '',
                  cat: 'someCategory',
                ));
          },
          child: Row(
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
        ),
        kHiegth18,
        if (requests.isEmpty)
          GestureDetector(
            onTap: () => _showAddRequestDialog(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add notes".tr,
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
          ),
        kHiegth9,
        ...requests.map((request) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kBorderLiteBlack),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(color: Colors.black54, fontSize: 42),
                    ),
                    Expanded(
                      child: Text(
                        request,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: kDarkOrange),
                      onPressed: () => _removeRequest(request),
                    ),
                  ],
                ),
              ),
            )),
      ],
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
                String request = requestController.text.trim();

                if (request.isNotEmpty) {
                  // Limit the request to 100 words
                  List<String> words = request.split(' ');
                  if (words.length > 100) {
                    words = words.sublist(0, 100);
                    request = words.join(' ') + '...';
                  }

                  setState(() {
                    if (!requests.contains(request)) {
                      requests.add(request);
                      _saveRequests();
                    }
                  });
                }

                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeRequest(String request) {
    setState(() {
      requests.remove(request);
      _saveRequests();
    });
  }

  void _saveRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('requests', requests);
  }

  void _loadRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      requests = prefs.getStringList('requests') ?? [];
    });
  }
}

