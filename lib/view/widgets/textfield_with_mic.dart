import 'package:flutter/material.dart';

class TextfieldWithMic extends StatelessWidget {
  const TextfieldWithMic({
    super.key,
    required this.hintText,
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      decoration: InputDecoration(
        prefixIcon: Image.asset("assets/icons/search_icon.png"),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.shade400,
              width: 1,
              height: 20,
            ),
            const SizedBox(width: 8),
            Image.asset("assets/icons/mic_icon.png"),
          ],
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    );
  }
}
