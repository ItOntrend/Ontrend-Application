import 'package:flutter/material.dart';

class NEcartBar extends StatelessWidget {
  const NEcartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Center(
        child: Text("No Notification"),
      ),
      // ListView(
      //   scrollDirection: Axis.vertical,
      //   children:  [
      //     NotificationCard(
      //       title: "Soften Future",
      //       image: "assets/image/soften_future_image.png",
      //     ),
      //     kHiegth25,
      //   ],
      // ),
    );
  }
}
