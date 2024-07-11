import 'package:cloud_firestore/cloud_firestore.dart';

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
        createdTime: createdTime ?? this.createdTime,
        reference: reference  ?? this.reference,
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
        dayWiseOpenAndClosingTime: dayWiseOpenAndClosingTime ?? this.dayWiseOpenAndClosingTime,
      );

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    ownerName: json["ownerName"],
    restaurantName: json["restaurantName"],
    email: json["email"],
    phone: json["phone"],
    category: json["category"],
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
    "workingDays":workingDays,
    "timeStamp":createdTime,
    "reference":reference,
    "businessAddress":businessAddress,
    "isApproved":isApproved,
    "emailVerified":emailverified,
    "image":image,
    "role":role,
    "location":location.toJson(),
    "bannerImage":bannerImage,
    "openingTime":openingTime,
    "closingTime":closingTime,
    "isOnline":isOnline,
    "dayWiseOpenAndClosingTime":dayWiseOpenAndClosingTime,
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
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}