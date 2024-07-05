import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String name;
  int price;
  String? tag;
  String? type;
  int? vId;
  String? addedBy;
  String description;
  String imageUrl;
  int? preparationTime;
  double? rating;
  int? itemPrice;
  DateTime? timeStamp;
  DocumentReference? reference;

  ItemModel({
    required this.name,
    required this.price,
     this.tag,
     this.type,
     this.vId,
     this.addedBy,
    required this.description,
    required this.imageUrl,
     this.preparationTime,
     this.rating,
     this.itemPrice,
     this.timeStamp,
     this.reference,
  });

  ItemModel copyWith({
    String? name,
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
  }) =>
      ItemModel(
        name: name ?? this.name,
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
      );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        name: json["name"],
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
      );

  Map<String, dynamic> toJson() => {
        "name": name,
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
      };
}
