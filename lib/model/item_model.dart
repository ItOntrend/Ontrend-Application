import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String name;
  String localName;
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
      timeStamp: json["timeStamp"].toDate(),
      restaurantName: json["restaurantName"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "localName": localName,
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
}
