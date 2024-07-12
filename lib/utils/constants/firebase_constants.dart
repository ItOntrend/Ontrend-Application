import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseConstants {
  static final authInstance = FirebaseAuth.instance;
  static final dbInstance = FirebaseFirestore.instance;
  static const String food = "Food";
  static const String grocery = "Grocery";
  static const String users = "users";
  static const String products = "products";
  static const String items = "items";
  static const String categories = "categories";
  static const String bestSeller = "Best Seller";
  static const String details = "details";
}
