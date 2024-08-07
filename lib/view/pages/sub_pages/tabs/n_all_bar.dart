import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/notification_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';

class NAllBar extends StatelessWidget {
  const NAllBar({super.key});

  Future<List<NotificationModel>> _getNotifications() async {
    var box = await LocalStorage.instance
        .openBox<NotificationModel>(HiveBox.commonBox);
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationModel>>(
      future: _getNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No Notifications".tr));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var notification = snapshot.data![index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(notification.date.toString()),
            );
          },
        );
      },
    );
  }
}
