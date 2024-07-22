import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';

class SearchResultHome extends StatelessWidget {
  final List<ItemModel> items;
  final List<ItemModel> restaurants;
  final String title;

  const SearchResultHome({
    Key? key,
    required this.items,
    required this.restaurants,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (items.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items:',
                      style: Theme.of(context).textTheme.headlineMedium),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.name),
                        onTap: () {
                          if (item.addedBy != null) {
                            final type = item.reference!.path.split('/')[0];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  userId: item.addedBy!,
                                  cat: "",
                                  type: type,
                                ),
                              ),
                            );
                          }
                          // Handle item tap
                        },
                      );
                    },
                  ),
                ],
              ),
            if (restaurants.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Restaurants:',
                      style: Theme.of(context).textTheme.headlineMedium),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final item = restaurants[index];
                      return ListTile(
                        title: Text(item.restaurantName ?? ''),
                        onTap: () {
                          if (item.addedBy != null) {
                            final type = item.reference!.path.split('/')[0];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  userId: item.addedBy!,
                                  cat: "",
                                  type: type,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
