import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String id;
  final String location;
  final String name;
  final String rating;
  final String image;
  Store(
      {required this.location,
      required this.name,
      required this.id,
      required this.rating,
      required this.image});

  factory Store.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Store(
        location: data['location'],
        name: data['name'],
        id: data['id'],
        rating: data['rating'],
        image: data['image']);
  }
}
