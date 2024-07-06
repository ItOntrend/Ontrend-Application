import 'package:cloud_firestore/cloud_firestore.dart';

class BestSellerModel {
  final String name;
  final String image;
  final int price;
  final String addedBy;
  final String restaurantName;

  BestSellerModel({
    required this.name,
    required this.image,
    required this.price,
    required this.addedBy,
    required this.restaurantName
  });

  Map<String, dynamic> toJason() => {
        'name': name,
        'imageUrl': image,
        'price': price,
        'addedBy': addedBy,
        'restaurantName': restaurantName
      };

  static BestSellerModel fromJson(Map<String, dynamic> json) => BestSellerModel(
        image: json['imageUrl'] ?? '',
        name: json['name'] ?? '',
        price: json['price'] is int
            ? json['price']
            : (json['price'] is String
                ? int.tryParse(json['price']) ?? 0
                : (json['price'] as double).toInt()),
        addedBy: json['addedBy'] ?? '',
        restaurantName: json['restaurantName'] ?? '',
      );

  static Future<void> getBestSeller({
    required String category,
    required String image,
    required int price,
    required String addedBy,
    required String restaurantName,
  }) async {
    final docBestSeller = FirebaseFirestore.instance
        .collection('Food')
        .doc('items')
        .collection('categories')
        .doc("Best Seller")
        .collection("details");

    final details = BestSellerModel(
      name: category,
      image: image,
      price: price,
      addedBy: addedBy,
      restaurantName: restaurantName,
    );

    final json = details.toJason();
    await docBestSeller.add(json);
  }
}
