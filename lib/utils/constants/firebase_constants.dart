import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseConstants {
  static final authInstance = FirebaseAuth.instance;
  static final dbInstance = FirebaseFirestore.instance;
  static const String food = "Food";
  static const String items = "items";
  static const String categories = "categories";
  static const String details = "details";
}
