import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SRoundedImageWidget extends StatelessWidget {
  const SRoundedImageWidget({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = false,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.isnetworkImage = true,
    this.borderRadius = 8,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isnetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.vertical(top: Radius.circular(15)),
          child: isnetworkImage
              ? CachedNetworkImage(imageUrl: imageUrl, fit: fit)
              : Image.asset(imageUrl, fit: fit),
        ),
      ),
    );
  }
}
