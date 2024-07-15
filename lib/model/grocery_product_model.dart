import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String name;
  String localName;
  double price;
  String tag;
  String localTag;
  String restaurantName;
  int vId;
  String addedBy;
  String description;
  String imageUrl;
  int preparationTime;
  double itemPrice;
  DateTime timeStamp;
  DocumentReference reference;
  bool isApproved;

  ProductModel({
    required this.name,
    required this.localName,
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
  });

  ProductModel copyWith({
    String? name,
    String? localName,
    double? price,
    String? tag,
    String? localTag,
    String? restaurantName,
    int? vId,
    String? addedBy,
    String? description,
    String? imageUrl,
    int? preparationTime,
    double? itemPrice,
    DateTime? timeStamp,
    DocumentReference? reference,
    bool? isApproved,
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
        isApproved: isApproved ?? this.isApproved,
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
        restaurantName: json["restaurantName"] ?? "",
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
        "isApproved": isApproved,
      };
}
