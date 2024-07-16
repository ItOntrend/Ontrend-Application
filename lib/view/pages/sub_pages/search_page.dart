import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [];
  bool _hasSearched = false;

  void _addToRecentSearches(String searchTerm) {
    setState(() {
      // Remove searchTerm if it exists to prioritize showing it at the top
      _recentSearches.remove(searchTerm);
      // Add searchTerm at the beginning of the list
      _recentSearches.insert(0, searchTerm);
      // Limit the recent searches to a certain number, e.g., 5
      if (_recentSearches.length > 5) {
        _recentSearches.removeLast();
      }
      // Mark that a search has been performed
      _hasSearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Search".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: TextfieldWithMic(
                hintText: "Biryani, Burger, Ice Cream...".tr,
                controller: _searchController,
                onSubmitted: (value) {
                  _addToRecentSearches(value);
                  // Implement your search logic here
                },
              ),
            ),
            SizedBox(height: 20.h),
            if (_hasSearched)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kLiteBackground,
                  border: Border.all(color: kBorderLiteBlack),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recently searched",
                      style: kTextStyle14Grey,
                    ),
                    SizedBox(height: 20.h),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _recentSearches
                          .map((searchTerm) => GestureDetector(
                                onTap: () {
                                  _searchController.text = searchTerm;
                                  _addToRecentSearches(searchTerm);
                                  // Implement your search logic here
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: kBorderLiteBlack),
                                  ),
                                  child: Text(
                                    searchTerm,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
