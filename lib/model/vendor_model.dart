import 'package:cloud_firestore/cloud_firestore.dart';
/*
class VendorModel {
  DocumentReference reference;
  String ownerName;
  String restaurantName;
  String email;
  String phone;
  String category;
  String bankingCode;
  bool delete;
  String accountNumber;
  String vendorId;
  String vatNumber;
  String businessAddress;
  Map workingDays;
  Map dayWiseOpenAndClosingTime;
  DateTime createdTime;
  bool isApproved;
  bool emailverified;
  String image;
  String role;
  Location location;
  String bannerImage;
  String closingTime;
  String openingTime;
  bool isOnline;

  VendorModel({
    required this.ownerName,
    required this.restaurantName,
    required this.email,
    required this.phone,
    required this.category,
    required this.bankingCode,
    required this.delete,
    required this.accountNumber,
    required this.vendorId,
    required this.vatNumber,
    required this.workingDays,
    required this.createdTime,
    required this.reference,
    required this.businessAddress,
    required this.emailverified,
    required this.isApproved,
    required this.image,
    required this.role,
    required this.location,
    required this.bannerImage,
    required this.openingTime,
    required this.closingTime,
    required this.isOnline,
    required this.dayWiseOpenAndClosingTime,
  });

  factory VendorModel.fromMap(Map<String, dynamic> data, String documentId) {
    return VendorModel(
      ownerName: data['ownerName'] ?? '',
      restaurantName: data['restaurantName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      category: data['category'] ?? '',
      bankingCode: data['bankCode'] ?? '',
      delete: data['delete'] ?? false,
      accountNumber: data['accountNumber'] ?? '',
      vendorId: data['vendorID'] ?? '',
      vatNumber: data['vatNumber'] ?? '',
      workingDays: data['workingDays'] ?? {},
      dayWiseOpenAndClosingTime: data['dayWiseOpenAndClosingTime'] ?? {},
      createdTime: data['timeStamp']?.toDate() ?? DateTime.now(),
      reference: FirebaseFirestore.instance.collection('users').doc(documentId),
      businessAddress: data['businessAddress'] ?? '',
      isApproved: data['isApproved'] ?? false,
      emailverified: data['emailVerified'] ?? false,
      image: data['image'] ?? '',
      role: data['role'] ?? '',
      location: data['location'] != null
          ? Location.fromJson(data['location'])
          : Location(lat: 0.0, lng: 0.0),
      bannerImage: data['bannerImage'] ?? '',
      openingTime: data['openingTime'] ?? '',
      closingTime: data['closingTime'] ?? '',
      isOnline: data['isOnline'] ?? false,
    );
  }

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        ownerName: json["ownerName"] ?? '',
        restaurantName: json["restaurantName"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        category: json["category"] ?? '',
        bankingCode: json["bankCode"] ?? '',
        delete: json["delete"] ?? false,
        accountNumber: json["accountNumber"] ?? '',
        vendorId: json["vendorID"] ?? '',
        vatNumber: json["vatNumber"] ?? '',
        workingDays: json["workingDays"] ?? {},
        dayWiseOpenAndClosingTime: json["dayWiseOpenAndClosingTime"] ?? {},
        createdTime: json['timeStamp']?.toDate() ?? DateTime.now(),
        reference: json['reference'] ??
            FirebaseFirestore.instance
                .collection('users')
                .doc(json['vendorID'] ?? ''),
        businessAddress: json['businessAddress'] ?? '',
        isApproved: json['isApproved'] ?? false,
        emailverified: json['emailVerified'] ?? false,
        image: json['image'] ?? '',
        role: json['role'] ?? '',
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : Location(lat: 0.0, lng: 0.0),
        bannerImage: json['bannerImage'] ?? '',
        openingTime: json['openingTime'] ?? '',
        closingTime: json['closingTime'] ?? '',
        isOnline: json['isOnline'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "ownerName": ownerName,
        "restaurantName": restaurantName,
        "email": email,
        "phone": phone,
        "category": category,
        "bankCode": bankingCode,
        "delete": delete,
        "accountNumber": accountNumber,
        "vendorID": vendorId,
        "vatNumber": vatNumber,
        "workingDays": workingDays,
        "timeStamp": createdTime,
        "reference": reference,
        "businessAddress": businessAddress,
        "isApproved": isApproved,
        "emailVerified": emailverified,
        "image": image,
        "role": role,
        "location": location.toJson(),
        "bannerImage": bannerImage,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "isOnline": isOnline,
        "dayWiseOpenAndClosingTime": dayWiseOpenAndClosingTime,
      };

  VendorModel copyWith({
    String? ownerName,
    String? restaurantName,
    String? email,
    String? phone,
    String? category,
    String? bankingCode,
    bool? delete,
    String? accountNumber,
    String? vendorId,
    String? vatNumber,
    String? businessAddress,
    Map? workingDays,
    Map? dayWiseOpenAndClosingTime,
    DateTime? createdTime,
    DocumentReference? reference,
    bool? isApproved,
    bool? emailverified,
    String? image,
    String? role,
    Location? location,
    String? bannerImage,
    String? openingTime,
    String? closingTime,
    bool? isOnline,
  }) =>
      VendorModel(
        ownerName: ownerName ?? this.ownerName,
        restaurantName: restaurantName ?? this.restaurantName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        category: category ?? this.category,
        bankingCode: bankingCode ?? this.bankingCode,
        delete: delete ?? this.delete,
        accountNumber: accountNumber ?? this.accountNumber,
        vendorId: vendorId ?? this.vendorId,
        vatNumber: vatNumber ?? this.vatNumber,
        workingDays: workingDays ?? this.workingDays,
        dayWiseOpenAndClosingTime:
            dayWiseOpenAndClosingTime ?? this.dayWiseOpenAndClosingTime,
        createdTime: createdTime ?? this.createdTime,
        reference: reference ?? this.reference,
        businessAddress: businessAddress ?? this.businessAddress,
        emailverified: emailverified ?? this.emailverified,
        isApproved: isApproved ?? this.isApproved,
        image: image ?? this.image,
        role: role ?? this.role,
        location: location ?? this.location,
        bannerImage: bannerImage ?? this.bannerImage,
        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        isOnline: isOnline ?? this.isOnline,
      );
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) =>
      Location(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble() ?? 0.0,
        lng: json["lng"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
*/

class VendorModel {
  DocumentReference reference;
  String ownerName;
  String restaurantName;
  String restaurantArabicName;
  String email;
  String phone;
  String vendorType;
  String bankingCode;
  bool delete;
  String accountNumber;
  String vendorId;
  String vatNumber;
  String businessAddress;
  Map workingDays;
  Map dayWiseOpenAndClosingTime;
  DateTime createdTime;
  bool isApproved;
  bool emailverified;
  String image;
  String role;
  Location location;
  String bannerImage;
  String closingTime;
  String openingTime;
  bool isOnline;
  int commissionRate;
  VendorModel({
    required this.ownerName,
    required this.restaurantName,
    required this.restaurantArabicName,
    required this.email,
    required this.phone,
    required this.vendorType,
    required this.bankingCode,
    required this.delete,
    required this.accountNumber,
    required this.vendorId,
    required this.vatNumber,
    required this.workingDays,
    required this.createdTime,
    required this.reference,
    required this.businessAddress,
    required this.emailverified,
    required this.isApproved,
    required this.image,
    required this.role,
    required this.location,
    required this.bannerImage,
    required this.openingTime,
    required this.closingTime,
    required this.isOnline,
    required this.dayWiseOpenAndClosingTime,
    this.commissionRate = 0,
  });

  VendorModel copyWith({
    String? ownerName,
    String? restaurantName,
    String? restaurantArabicName,
    String? email,
    String? phone,
    String? vendorType,
    String? bankingCode,
    bool? delete,
    String? accountNumber,
    String? vendorId,
    String? vatNumber,
    String? businessAddress,
    String? password,
    Map? workingDays,
    Map? dayWiseOpenAndClosingTime,
    DateTime? createdTime,
    DocumentReference? reference,
    bool? isApproved,
    bool? emailverified,
    String? image,
    String? role,
    Location? location,
    String? bannerImage,
    String? openingTime,
    String? closingTime,
    bool? isOnline,
    int? commissionRate,
  }) =>
      VendorModel(
        ownerName: ownerName ?? this.ownerName,
        restaurantName: restaurantName ?? this.restaurantName,
        restaurantArabicName: restaurantArabicName ?? this.restaurantArabicName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        vendorType: vendorType ?? this.vendorType,
        bankingCode: bankingCode ?? this.bankingCode,
        delete: delete ?? this.delete,
        accountNumber: accountNumber ?? this.accountNumber,
        vendorId: vendorId ?? this.vendorId,
        vatNumber: vatNumber ?? this.vatNumber,
        workingDays: workingDays ?? this.workingDays,
        createdTime: createdTime ?? this.createdTime,
        reference: reference ?? this.reference,
        businessAddress: businessAddress ?? this.businessAddress,
        emailverified: emailverified ?? this.emailverified,
        isApproved: isApproved ?? this.isApproved,
        image: image ?? this.image,
        role: role ?? this.role,
        location: location ?? this.location,
        bannerImage: bannerImage ?? this.bannerImage,
        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        isOnline: isOnline ?? this.isOnline,
        dayWiseOpenAndClosingTime:
            dayWiseOpenAndClosingTime ?? this.dayWiseOpenAndClosingTime,
        commissionRate: commissionRate ?? this.commissionRate,
      );
  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      ownerName: json['ownerName'] as String? ?? 'No Name',
      restaurantName: json['restaurantName'] as String? ?? 'No Restaurant Name',
      restaurantArabicName: json['restaurantArabicName'] as String? ?? '',
      email: json['email'] as String? ?? 'No Email',
      phone: json['phone'] as String? ?? 'No Phone',
      vendorType: json['vendorType'] as String? ?? 'No Vendor Type',
      bankingCode: json['bankCode'] as String? ?? 'No Banking Code',
      delete: json['delete'] as bool? ?? false,
      accountNumber: json['accountNumber'] as String? ?? 'No Account Number',
      vendorId: json['vendorID'] as String? ?? 'No Vendor ID',
      vatNumber: json['vatNumber'] as String? ?? 'No VAT Number',
      businessAddress: json['businessAddress'] as String? ?? 'No Address',
      workingDays: json['workingDays'] as Map<dynamic, dynamic>? ?? {},
      dayWiseOpenAndClosingTime:
          json['dayWiseOpenAndClosingTime'] as Map<dynamic, dynamic>? ?? {},
      createdTime:
          (json['timeStamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isApproved: json['isApproved'] as bool? ?? false,
      emailverified: json['emailVerified'] as bool? ?? false,
      image: json['image'] as String? ?? 'No Image',
      role: json['role'] as String? ?? 'No Role',
      location:
          Location.fromJson(json['location'] as Map<String, dynamic>? ?? {}),
      bannerImage: json['bannerImage'] as String? ?? 'No Banner Image',
      openingTime: json['openingTime'] as String? ?? 'No Opening Time',
      closingTime: json['closingTime'] as String? ?? 'No Closing Time',
      isOnline: json['isOnline'] as bool? ?? false,
      commmisionRate: json['commissionRate'] as int? ?? 0,
      reference: json['reference'] as DocumentReference,
    );
  }
/*
  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        ownerName: json["ownerName"],
        restaurantName: json["restaurantName"],
        restaurantArabicName: json["restaurantArabicName"],
        email: json["email"],
        phone: json["phone"],
        vendorType: json["vendorType"],
        bankingCode: json["bankCode"],
        delete: json["delete"],
        accountNumber: json["accountNumber"],
        vendorId: json["vendorID"],
        vatNumber: json["vatNumber"],
        workingDays: json["workingDays"],
        dayWiseOpenAndClosingTime: json["dayWiseOpenAndClosingTime"],
        createdTime: json['timeStamp'].toDate(),
        reference: json['reference'],
        businessAddress: json['businessAddress'],
        isApproved: json['isApproved'],
        emailverified: json['emailVerified'],
        image: json['image'],
        role: json['role'],
        location: Location.fromJson(json['location']),
        bannerImage: json['bannerImage'],
        openingTime: json['openingTime'],
        closingTime: json['closingTime'],
        isOnline: json['isOnline'],
        commissionRate: json['commissionRate'],
      );
*/
  Map<String, dynamic> toJson() => {
        "ownerName": ownerName,
        "restaurantName": restaurantName,
        "restaurantArabicName": restaurantArabicName,
        "email": email,
        "phone": phone,
        "vendorType": vendorType,
        "bankCode": bankingCode,
        "delete": delete,
        "accountNumber": accountNumber,
        "vendorID": vendorId,
        "vatNumber": vatNumber,
        "workingDays": workingDays,
        "timeStamp": createdTime,
        "reference": reference,
        "businessAddress": businessAddress,
        "isApproved": isApproved,
        "emailVerified": emailverified,
        "image": image,
        "role": role,
        "location": location.toJson(),
        "bannerImage": bannerImage,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "isOnline": isOnline,
        "dayWiseOpenAndClosingTime": dayWiseOpenAndClosingTime,
        "commissionRate": commissionRate,
      };
  factory VendorModel.fromMap(Map<String, dynamic> data, String documentId) {
    return VendorModel(
      ownerName: data['ownerName'] ?? '',
      restaurantName: data['restaurantName'] ?? '',
      restaurantArabicName: data['restaurantArabicName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      vendorType: data['vendorType'] ?? '',
      bankingCode: data['bankCode'] ?? '',
      delete: data['delete'] ?? false,
      accountNumber: data['accountNumber'] ?? '',
      vendorId: data['vendorID'] ?? '',
      vatNumber: data['vatNumber'] ?? '',
      workingDays: data['workingDays'] ?? {},
      dayWiseOpenAndClosingTime: data['dayWiseOpenAndClosingTime'] ?? {},
      createdTime: data['timeStamp']?.toDate() ?? DateTime.now(),
      reference: FirebaseFirestore.instance.collection('users').doc(documentId),
      businessAddress: data['businessAddress'] ?? '',
      isApproved: data['isApproved'] ?? false,
      emailverified: data['emailVerified'] ?? false,
      image: data['image'] ?? '',
      role: data['role'] ?? '',
      location: data['location'] != null
          ? Location.fromJson(data['location'])
          : Location(lat: 0.0, lng: 0.0),
      bannerImage: data['bannerImage'] ?? '',
      openingTime: data['openingTime'] ?? '',
      closingTime: data['closingTime'] ?? '',
      isOnline: data['isOnline'] ?? false,
      commissionRate: data['commissionRate'] ?? 0,
    );
  }
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) =>
      Location(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
