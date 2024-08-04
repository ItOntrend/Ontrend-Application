import 'package:cloud_firestore/cloud_firestore.dart';
/*
class ItemModel {
  String name;
  String localName;
  String arabicRestaurantName;
  String localTag;
  int price;
  String? tag;
  String? type;
  int? vId;
  String addedBy;
  String description;
  String imageUrl;
  int? preparationTime;
  double? rating;
  int? itemPrice;
  DateTime? timeStamp;
  DocumentReference? reference;
  String restaurantName;

  ItemModel({
    required this.name,
    required this.localName,
    required this.arabicRestaurantName,
    required this.localTag,
    required this.price,
    this.tag,
    this.type,
    this.vId,
    required this.addedBy,
    required this.description,
    required this.imageUrl,
    this.preparationTime,
    this.rating,
    this.itemPrice,
    this.timeStamp,
    this.reference,
    required this.restaurantName,
  });

  ItemModel copyWith(
          {String? name,
          String? localName,
          String? arabicrestaurantName,
          String? localTag,
          int? price,
          String? tag,
          String? type,
          int? vId,
          String? addedBy,
          String? description,
          String? imageUrl,
          int? preparationTime,
          double? rating,
          int? itemPrice,
          DateTime? timeStamp,
          DocumentReference? reference,
          String? restaurantName,
          int? quantity}) =>
      ItemModel(
        name: name ?? this.name,
        localTag: localTag ?? this.localTag,
        localName: localName ?? this.localName,
        arabicRestaurantName: arabicRestaurantName ?? this.arabicRestaurantName,
        price: price ?? this.price,
        tag: tag ?? this.tag,
        type: type ?? this.type,
        vId: vId ?? this.vId,
        addedBy: addedBy ?? this.addedBy,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        preparationTime: preparationTime ?? this.preparationTime,
        rating: rating ?? this.rating,
        itemPrice: itemPrice ?? this.itemPrice,
        timeStamp: timeStamp ?? this.timeStamp,
        reference: reference ?? this.reference,
        restaurantName: restaurantName ?? this.restaurantName,
      );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
      name: json["name"],
      localName: json["localName"],
      arabicRestaurantName: json["arabicRestaurantName"],
      localTag: json["localTag"],
      price: (json["price"] is int)
          ? json["price"]
          : (json["price"] is double)
              ? json["price"].toInt()
              : 0,
      tag: json["tag"],
      type: json["type"],
      vId: json["vID"],
      addedBy: json["addedBy"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      preparationTime:
          json["preparationTime"] ?? 0, // Provide a default value if null,
      rating: json["rating"] ?? 0.0,
      itemPrice: (json["itemPrice"] is int)
          ? json["itemPrice"]
          : (json["itemPrice"] is double)
              ? json["itemPrice"].toInt()
              : 0,
      reference: json["reference"] ??
          FirebaseFirestore.instance
              .collection('default')
              .doc(), // Provide a default DocumentReference if null,
      timeStamp: json["timeStamp"] != null
          ? json["timeStamp"].toDate()
          : DateTime.now(),
      restaurantName: json["restaurantName"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "localName": localName,
        "arabicRestaurantName": arabicRestaurantName,
        "localTag": localTag,
        "price": price,
        "tag": tag,
        "type": type,
        "vID": vId,
        "addedBy": addedBy,
        "description": description,
        "imageUrl": imageUrl,
        "preparationTime": preparationTime,
        "rating": rating,
        "itemPrice": itemPrice,
        "timeStamp": timeStamp,
        "reference": reference,
        "restaurantName": restaurantName,
      };
  factory ItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ItemModel(
      name: data["name"],
      localName: data["localName"],
      arabicRestaurantName: data["arabicRestaurantName"],
      localTag: data["localTag"],
      price: (data["price"] is int)
          ? data["price"]
          : (data["price"] is double)
              ? data["price"].toInt()
              : 0,
      tag: data["tag"],
      type: data["type"],
      vId: data["vID"],
      addedBy: data["addedBy"],
      description: data["description"],
      imageUrl: data["imageUrl"],
      preparationTime: data["preparationTime"] ?? 0,
      rating: data["rating"] ?? 0.0,
      itemPrice: (data["itemPrice"] is int)
          ? data["itemPrice"]
          : (data["itemPrice"] is double)
              ? data["itemPrice"].toInt()
              : 0,
      reference: snapshot.reference,
      timeStamp: data["timeStamp"]?.toDate(),
      restaurantName: data["restaurantName"],
    );
  }
}*/
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
