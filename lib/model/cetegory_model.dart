import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String addedBy;
  String name;
  bool isApproved;
  String imageUrl;

  CategoryModel({
    required this.addedBy,
    required this.name,
    required this.isApproved,
    required this.imageUrl,
  });

  CategoryModel copyWith({
    String? addedBy,
    String? name,
    String? imageUrl,
    bool? isApproved,
  }) =>
      CategoryModel(
        addedBy: addedBy ?? this.addedBy,
        name: name ?? this.name,
        isApproved: isApproved ?? this.isApproved,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    addedBy: json["addedBy"],
    name: json["name"],
    isApproved: json["isApproved"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "addedBy": addedBy,
    "name": name,
    "isApproved": isApproved,
    "imageUrl": imageUrl,
  };
}