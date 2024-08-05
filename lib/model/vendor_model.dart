import 'package:cloud_firestore/cloud_firestore.dart';

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
  bool emailVerified;
  String image;
  String role;
  Location location;
  List<String> bannerImage;
  List<String> bannerVideo;

  String closingTime;
  String openingTime;
  bool isOnline;
  double? sellerEarnings; // Nullable
  int? commissionRate; // Nullable

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
    required this.emailVerified,
    required this.isApproved,
    required this.image,
    required this.role,
    required this.location,
    required this.bannerImage,
    required this.openingTime,
    required this.closingTime,
    required this.isOnline,
    required this.dayWiseOpenAndClosingTime,
    required this.sellerEarnings,
    required this.commissionRate,
    required this.bannerVideo,
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
    Map? workingDays,
    Map? dayWiseOpenAndClosingTime,
    DateTime? createdTime,
    DocumentReference? reference,
    bool? isApproved,
    bool? emailVerified,
    String? image,
    String? role,
    Location? location,
    List<String>? bannerImage,
    List<String>? bannerVideo,
    String? openingTime,
    String? closingTime,
    bool? isOnline,
    double? sellerEarnings,
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
        emailVerified: emailVerified ?? this.emailVerified,
        isApproved: isApproved ?? this.isApproved,
        image: image ?? this.image,
        role: role ?? this.role,
        location: location ?? this.location,
        bannerImage: bannerImage ?? this.bannerImage,
        bannerVideo: bannerVideo ?? this.bannerVideo,
        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        isOnline: isOnline ?? this.isOnline,
        sellerEarnings: sellerEarnings ?? this.sellerEarnings,
        commissionRate: commissionRate ?? this.commissionRate,
        dayWiseOpenAndClosingTime:
            dayWiseOpenAndClosingTime ?? this.dayWiseOpenAndClosingTime,
      );

  factory VendorModel.fromJson(Map<String, dynamic> json, String id) =>
      VendorModel(
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
        workingDays: json["workingDays"] ?? {},
        dayWiseOpenAndClosingTime: json["dayWiseOpenAndClosingTime"] ?? {},
        createdTime: (json['timeStamp'] as Timestamp).toDate(),
        reference: json['reference'] as DocumentReference,
        businessAddress: json['businessAddress'],
        isApproved: json['isApproved'],
        emailVerified: json['emailVerified'],
        image: json['image'],
        role: json['role'],
        location: Location.fromJson(json['location']),
        bannerImage: List<String>.from(
            json['bannerImage'] ?? []), // Cast to List<String>
        openingTime: json['openingTime'],
        closingTime: json['closingTime'],
        isOnline: json['isOnline'],
        sellerEarnings: json["sellerEarnings"] != null
            ? (json["sellerEarnings"] as num).toDouble()
            : null,
        commissionRate: json["commissionRate"] != null
            ? (json["commissionRate"] as num).toInt()
            : null,
      );

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
        "emailVerified": emailVerified,
        "image": image,
        "role": role,
        "location": location.toJson(),
        "bannerImage": bannerImage,
        "bannerVideo": bannerVideo,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "isOnline": isOnline,
        "dayWiseOpenAndClosingTime": dayWiseOpenAndClosingTime,
        "sellerEarnings": sellerEarnings,
        "commissionRate": commissionRate,
      };
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
        lat: (json["lat"] as num).toDouble(),
        lng: (json["lng"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
