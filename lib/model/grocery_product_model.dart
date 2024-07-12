import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String addedBy;
  String description;
  String imageUrl;
  String name;
  String preparationTime;
  String price;
  String stock;
  String tag;
  DateTime timeStamp;
  String type;
  String vID;

  ProductModel({
    required this.addedBy,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.preparationTime,
    required this.price,
    required this.stock,
    required this.tag,
    required this.timeStamp,
    required this.type,
    required this.vID,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      addedBy: json['addedBy'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
      preparationTime: json['preparationTime'] ?? '',
      price: json['price'] ?? '',
      stock: json['stock'] ?? '',
      tag: json['tag'] ?? '',
      timeStamp: (json['timeStamp'] as Timestamp).toDate(),
      type: json['type'] ?? '',
      vID: json['vID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addedBy': addedBy,
      'description': description,
      'imageUrl': imageUrl,
      'name': name,
      'preparationTime': preparationTime,
      'price': price,
      'stock': stock,
      'tag': tag,
      'timeStamp': timeStamp,
      'type': type,
      'vID': vID,
    };
  }
}
