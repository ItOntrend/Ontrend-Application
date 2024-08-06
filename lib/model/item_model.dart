import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  String name;
  String localName;
  double price;
  String tag;
  String localTag;
  String restaurantName;
  String arabicRestaurantName;
  int vId;
  String addedBy;
  String description;
  String imageUrl;
  int preparationTime;
  double itemPrice;
  DateTime timeStamp;
  DocumentReference reference;
  bool isApproved;
  ProductAvailable availableTime;
  bool isDisabled;
  Map<String, dynamic> variants;

  ProductModel({
    required this.name,
    required this.localName,
    required this.arabicRestaurantName,
    required this.price,
    required this.tag,
    required this.localTag,
    required this.vId,
    required this.addedBy,
    required this.description,
    required this.imageUrl,
    required this.preparationTime,
    required this.itemPrice,
    required this.timeStamp,
    required this.reference,
    required this.restaurantName,
    required this.isApproved,
    required this.isDisabled,
    required this.availableTime,
    required this.variants,
  });

  ProductModel copyWith({
    String? name,
    String? localName,
    double? price,
    String? tag,
    String? localTag,
    String? restaurantName,
    String? arabicRestaurantName,
    int? vId,
    String? addedBy,
    String? description,
    String? imageUrl,
    int? preparationTime,
    double? itemPrice,
    DateTime? timeStamp,
    DocumentReference? reference,
    bool? isApproved,
    bool? isDisabled,
    ProductAvailable? productAvailable,
    Map<String, dynamic>? variants,
  }) =>
      ProductModel(
        name: name ?? this.name,
        localName: localName ?? this.localName,
        price: price ?? this.price,
        tag: tag ?? this.tag,
        localTag: localTag ?? this.localTag,
        vId: vId ?? this.vId,
        addedBy: addedBy ?? this.addedBy,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        preparationTime: preparationTime ?? this.preparationTime,
        itemPrice: itemPrice ?? this.itemPrice,
        timeStamp: timeStamp ?? this.timeStamp,
        reference: reference ?? this.reference,
        restaurantName: restaurantName ?? this.restaurantName,
        arabicRestaurantName: arabicRestaurantName ?? this.arabicRestaurantName,
        isApproved: isApproved ?? this.isApproved,
        availableTime: productAvailable ?? this.availableTime,
        isDisabled: isDisabled ?? this.isDisabled,
        variants: variants ?? this.variants,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        localName: json["localName"],
        price: json["price"].toDouble() ?? 0,
        tag: json["tag"],
        localTag: json["localTag"],
        vId: json["vID"],
        addedBy: json["addedBy"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        preparationTime: json["preparationTime"],
        itemPrice: json["itemPrice"].toDouble() ?? 0,
        reference: json["reference"],
        isApproved: json["isApproved"],
        isDisabled: json["isDisabled"],
        variants: json["variants"] ?? {},
        availableTime: ProductAvailable.fromMap(json['availableTime']),
        restaurantName: json["restaurantName"] ?? "",
        arabicRestaurantName: json["arabicRestaurantName"] ?? "",
        timeStamp: json["timeStamp"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "localName": localName,
        "price": price,
        "tag": tag,
        "localTag": localTag,
        "vID": vId,
        "addedBy": addedBy,
        "description": description,
        "imageUrl": imageUrl,
        "preparationTime": preparationTime,
        "itemPrice": itemPrice,
        "timeStamp": timeStamp,
        "reference": reference,
        "restaurantName": restaurantName,
        "availableTime": availableTime.toMap(),
        "arabicRestaurantName": arabicRestaurantName,
        "isApproved": isApproved,
        "isDisabled": isDisabled,
        "variants": variants,
      };
}

class ProductAvailable {
  String from;
  String to;
  bool isAvailable;

  ProductAvailable({
    required this.from,
    required this.to,
    required this.isAvailable,
  });

  ProductAvailable copyWith({
    String? from,
    String? to,
    bool? isAvailable,
  }) {
    return ProductAvailable(
      from: from ?? this.from,
      to: to ?? this.to,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'from': this.from,
      'to': this.to,
      'isAvailable': this.isAvailable,
    };
  }

  factory ProductAvailable.fromMap(Map<String, dynamic> map) {
    return ProductAvailable(
      from: map['from'] as String,
      to: map['to'] as String,
      isAvailable: map['isAvailable'] as bool,
    );
  }
}
