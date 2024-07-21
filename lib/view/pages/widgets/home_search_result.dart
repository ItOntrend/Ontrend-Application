import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';

class SearchResultHome extends StatelessWidget {
  final String title;
  final List<ItemModel> products;

  const SearchResultHome({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroceryController groceryController = Get.put(GroceryController());
    final FoodController foodController = Get.put(FoodController());

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
                CategoryModel? category;
                String type = product.reference!.path.split('/')[0];
                // Check the type and get the corresponding category
                if (type == 'Grocery') {
                  print("type is $type");
                  category = groceryController.getCategoryByName(product.tag!);
                } else if (type == 'Food') {
                  print("type is $type");
                  category = foodController.getCategoryByName(product.tag!);
                }

                return CategoryCard(
                  categoryName: product.name,
                  categoryImage: product.imageUrl,
                  onTap: () {
                    if (category != null) {
                      print(
                          "Navigating to CategorySearchPage with category: ${category!.name}, type: $type");
                      Get.to(() => CategorysSearchPage(
                            category: category!,
                            type: type,
                          ));
                    } else {
                      print(
                          "Category not found for product: ${product.name}, type: $type");
                    }
                  },
                );
              },
            ),
    );
  }
}
