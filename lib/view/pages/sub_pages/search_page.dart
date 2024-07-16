import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final foodController = Get.find<FoodController>();

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
        title: const Text(
          "Search",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: TextfieldWithMic(
                hintText: "Biryani, Burger, Ice Cream...",
                controller: _searchController,
                onSubmitted: (value) {
                  _addToRecentSearches(value);
                  // Implement your search logic here
                },
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: (context, index) {},
            //   ),
            // ),
            kHiegth20,
            if (_hasSearched)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recently searched",
                      style: kTextStyle14Grey,
                    ),
                    kHiegth20,
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
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            kHiegth10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "What's on your mind",
                style: kTextStyle14Grey,
              ),
            ),
            kDiver,
            kHiegth10,
            Obx(
              () => foodController.isCategoryLoading.value
                  ? const CircularProgressIndicator()
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      scrollDirection: Axis.vertical,
                      itemCount: foodController.categoryList.length,
                      itemBuilder: (context, index) {
                        final category = foodController.categoryList[index];
                        return CategoryCard(
                          onTap: () {
                            Get.to(() => CategorysSearchPage(
                                  type: 'Food/Restaurant',
                                  categoryName: category.name,
                                ));
                          },
                          categoryName: category.name,
                          categoryImage: category.imageUrl,
                        );
                      },
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
