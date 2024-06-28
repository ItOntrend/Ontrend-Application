import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String name;
  final String image;

  CategoryModel({
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toJason() => {
        'name': name,
        'imageUrl': image,
      };

  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        image: json['imageUrl'],
        name: json['name'],
      );

  static Future<void> addCategory({
    required String category,
    required String image,
  }) async {
    final docCategory = FirebaseFirestore.instance
        .collection('Gestapo')
        .doc('Admin')
        .collection('Category')
        .doc(category);

    final categories = CategoryModel(
      name: category,
      image: image,
    );

    final json = categories.toJason();
    await docCategory.set(json);
  }
}
