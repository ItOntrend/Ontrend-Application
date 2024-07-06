class OrderModel {
  String addedBy;
  double adminEarnings;
  bool deliveryAccepted;
  DeliveryLocation deliveryLocation;
  double discountApplied;
  List<Item> items;
  dynamic promoCode;
  String status;
  double totalPrice;
  String userId;
  String paymentType;
  String restaurantName;
  DateTime orderTimestamp;
  String orderID;

  OrderModel({
    required this.addedBy,
    required this.adminEarnings,
    required this.discountApplied,
    required this.items,
    required this.promoCode,
    required this.status,
    required this.totalPrice,
    required this.userId,
    required this.orderTimestamp,
    required this.orderID,
    required this.paymentType,
    required this.restaurantName,
    required this.deliveryLocation,
    required this.deliveryAccepted,
  });

  OrderModel copyWith({
    String? addedBy,
    double? adminEarnings,
    double? discountApplied,
    bool? deliveryAccepted,
    List<Item>? items,
    dynamic promoCode,
    DeliveryLocation? deliveryLocation,
    String? status,
    double? totalPrice,
    String? userId,
    String? orderID,
    String? restaurantName,
    String? paymentType,
    DateTime? orderTimestamp,
  }) =>
      OrderModel(
          addedBy: addedBy ?? this.addedBy,
          adminEarnings: adminEarnings ?? this.adminEarnings,
          discountApplied: discountApplied ?? this.discountApplied,
          items: items ?? this.items,
          promoCode: promoCode ?? this.promoCode,
          status: status ?? this.status,
          totalPrice: totalPrice ?? this.totalPrice,
          userId: userId ?? this.userId,
          orderTimestamp: orderTimestamp ?? this.orderTimestamp,
          orderID: orderID ?? this.orderID,
          restaurantName: restaurantName ?? this.restaurantName,
          paymentType: paymentType ?? this.paymentType,
          deliveryLocation: deliveryLocation ?? this.deliveryLocation,
          deliveryAccepted: deliveryAccepted ?? this.deliveryAccepted);

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        addedBy: json["addedBy"] ?? "",
        adminEarnings: json["adminEarnings"].toDouble() ?? 0,
        discountApplied: json["discountApplied"].toDouble() ?? 0,
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        promoCode: json["promoCode"] ?? "",
        deliveryLocation: DeliveryLocation.fromJson(json['deliveryLocation']),
        status: json["status"] ?? "",
        totalPrice: json["totalPrice"].toDouble() ?? 0,
        userId: json["userID"] ?? "",
        orderID: json["orderID"] ?? "",
        paymentType: json['paymentType'] ?? "",
        deliveryAccepted: json['deliveryAccepted'],
        restaurantName: json['restaurantName'] ?? "",
        orderTimestamp: json["orderTimeStamp"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "addedBy": addedBy,
        "adminEarnings": adminEarnings,
        "discountApplied": discountApplied,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "promoCode": promoCode,
        "status": status,
        "totalPrice": totalPrice,
        "userID": userId,
        "orderTimeStamp": orderTimestamp,
        "orderID": orderID,
        "restaurantName": restaurantName,
        "paymentType": paymentType,
        "deliveryLocation": deliveryLocation.toJson(),
        "deliveryAccepted": deliveryAccepted,
      };
}

class Item {
  String addedBy;
  String itemName;
  double itemPrice;
  int itemQuantity;
  double total;

  Item({
    required this.addedBy,
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
    required this.total,
  });

  Item copyWith({
    String? addedBy,
    String? itemName,
    double? itemPrice,
    int? itemQuantity,
    double? total,
  }) =>
      Item(
        addedBy: addedBy ?? this.addedBy,
        itemName: itemName ?? this.itemName,
        itemPrice: itemPrice ?? this.itemPrice,
        itemQuantity: itemQuantity ?? this.itemQuantity,
        total: total ?? this.total,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        addedBy: json["addedBy"],
        itemName: json["itemName"],
        itemPrice: json["itemPrice"].toDouble() ?? 0,
        itemQuantity: json["itemQuantity"],
        total: json["total"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "addedBy": addedBy,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemQuantity": itemQuantity,
        "total": total,
      };
}

class DeliveryLocation {
  String address;
  String apartmentNumber;
  String city;
  String houseNumber;
  double lat;
  double lng;
  String street;

  DeliveryLocation({
    required this.address,
    required this.apartmentNumber,
    required this.city,
    required this.houseNumber,
    required this.lat,
    required this.lng,
    required this.street,
  });

  DeliveryLocation copyWith({
    String? address,
    String? apartmentNumber,
    String? city,
    String? houseNumber,
    double? lat,
    double? lng,
    String? street,
  }) =>
      DeliveryLocation(
        address: address ?? this.address,
        apartmentNumber: apartmentNumber ?? this.apartmentNumber,
        city: city ?? this.city,
        houseNumber: houseNumber ?? this.houseNumber,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        street: street ?? this.street,
      );

  factory DeliveryLocation.fromJson(Map<String, dynamic> json) =>
      DeliveryLocation(
        address: json["address"],
        apartmentNumber: json["apartmentNumber"],
        city: json["city"],
        houseNumber: json["houseNumber"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        street: json["street"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "apartmentNumber": apartmentNumber,
        "city": city,
        "houseNumber": houseNumber,
        "lat": lat,
        "lng": lng,
        "street": street,
      };
}
