import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  String type;

  @HiveField(3)
  DateTime date;

  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.date,
  });
}
