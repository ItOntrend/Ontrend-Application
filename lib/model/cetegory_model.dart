import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String addedBy;
  String name;
  String localName;
  bool isApproved;
  String imageUrl;

  CategoryModel({
    required this.addedBy,
    required this.name,
    required this.localName,
    required this.isApproved,
    required this.imageUrl,
  });

  CategoryModel copyWith({
    String? addedBy,
    String? name,
    String? localName,
    String? imageUrl,
    bool? isApproved,
  }) =>
      CategoryModel(
        addedBy: addedBy ?? this.addedBy,
        name: name ?? this.name,
        localName: localName ?? this.localName,
        isApproved: isApproved ?? this.isApproved,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        addedBy: json["addedBy"] ?? '',
        name: json["name"] ?? '',
        localName: json["localName"] ?? '',
        isApproved: json["isApproved"] ?? false,
        imageUrl: json["imageUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "addedBy": addedBy,
        "name": name,
        "localName": localName,
        "isApproved": isApproved,
        "imageUrl": imageUrl,
      }; // Add the fromSnapshot method
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      addedBy: data["addedBy"],
      name: data["name"],
      localName: data["localName"],
      isApproved: data["isApproved"],
      imageUrl: data["imageUrl"],
    );
  }
}
