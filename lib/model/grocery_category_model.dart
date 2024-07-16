import 'dart:convert';

grCategoryModel grcategoryModelFromJson(String str) =>
    grCategoryModel.fromJson(json.decode(str));

String grcategoryModelToJson(grCategoryModel data) =>
    json.encode(data.toJson());

class grCategoryModel {
  String addedBy;
  String name;
  String localName;
  bool isApproved;
  String imageUrl;

  grCategoryModel({
    required this.addedBy,
    required this.name,
    required this.localName,
    required this.isApproved,
    required this.imageUrl,
  });

  grCategoryModel copyWith({
    String? addedBy,
    String? name,
    String? localName,
    String? imageUrl,
    bool? isApproved,
  }) =>
      grCategoryModel(
        addedBy: addedBy ?? this.addedBy,
        name: name ?? this.name,
        localName: localName ?? this.localName,
        isApproved: isApproved ?? this.isApproved,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory grCategoryModel.fromJson(Map<String, dynamic> json) =>
      grCategoryModel(
        addedBy: json["addedBy"],
        name: json["name"],
        localName: json["localName"],
        isApproved: json["isApproved"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "addedBy": addedBy,
        "name": name,
        "localName": localName,
        "isApproved": isApproved,
        "imageUrl": imageUrl,
      };
}
