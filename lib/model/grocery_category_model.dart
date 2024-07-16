import 'dart:convert';

grCategoryModel grcategoryModelFromJson(String str) =>
    grCategoryModel.fromJson(json.decode(str));

String grcategoryModelToJson(grCategoryModel data) =>
    json.encode(data.toJson());

class grCategoryModel {
  String addedBy;
  String name;
  bool isApproved;
  String imageUrl;

  grCategoryModel({
    required this.addedBy,
    required this.name,
    required this.isApproved,
    required this.imageUrl,
  });

  grCategoryModel copyWith({
    String? addedBy,
    String? name,
    String? imageUrl,
    bool? isApproved,
  }) =>
      grCategoryModel(
        addedBy: addedBy ?? this.addedBy,
        name: name ?? this.name,
        isApproved: isApproved ?? this.isApproved,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory grCategoryModel.fromJson(Map<String, dynamic> json) =>
      grCategoryModel(
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
