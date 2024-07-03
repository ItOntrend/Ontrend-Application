import 'package:cloud_firestore/cloud_firestore.dart';

class BestSellerModel {
  final String name;
  final String image;
  final int price;
  final String addedBy;

  BestSellerModel({
    required this.name,
    required this.image,
    required this.price,
    required this.addedBy,
  });

  Map<String, dynamic> toJason() => {
        'name': name,
        'imageUrl': image,
        'price': price,
        'addedBy': addedBy,
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
      );

  static Future<void> getBestSeller({
    required String category,
    required String image,
    required int price,
    required String addedBy,
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
    );

    final json = details.toJason();
    await docBestSeller.add(json);
  }
}
