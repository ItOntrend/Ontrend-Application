import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  String restaurantName;
  String image;
  String bannerImage;
  String vendorId; // Changed to String to match the data type issue
  DocumentReference reference;

  Vendor({
    required this.restaurantName,
    required this.image,
    required this.bannerImage,
    required this.vendorId,
    required this.reference,
  });

  factory Vendor.fromMap(Map<String, dynamic> data) {
    return Vendor(
      restaurantName: data['restaurantName'] ?? '',
      image: data['image'] ?? '',
      bannerImage: data['bannerImage'] ?? '',
      vendorId: data['vendorID']?.toString() ?? '',
      reference: data["reference"], // Ensuring it's a String
    );
  }
}

class Item {
  String itemName;
  double itemPrice;
  String imageUrl;
  String description;
  String addedBy;

  Item({
    required this.itemName,
    required this.itemPrice,
    required this.imageUrl,
    required this.description,
    required this.addedBy,
  });

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      itemName: data['name'] ?? '',
      itemPrice: (data['itemPrice'] ?? 0).toDouble(), // Ensure it's a double
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      addedBy: data['addedBy'] ?? '',
    );
  }
}
