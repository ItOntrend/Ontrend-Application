import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';

class SearchResult extends StatelessWidget {
  final String title;
  final List<ItemModel> products;

  const SearchResult({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GroceryController gc = Get.put(GroceryController());
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: products.isEmpty
          ? Center(child: Text('No products found'))
          : GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of rows
                crossAxisSpacing: 10,
                childAspectRatio:
                    0.75, // Adjust the aspect ratio based on your design
              ),
              itemCount: products.length,
              itemBuilder: (_, index) {
                ItemModel product = products[index];
                CategoryModel? category = gc.getCategoryByName(product.tag!);

                return CategoryCard(
                  categoryName: product.name,
                  categoryImage: product.imageUrl,
                  onTap: () => Get.to(() => CategorysSearchPage(
                        category: category!,
                        type: 'Grocery',
                      )),
                );
              },
            ),
    );
  }
}
