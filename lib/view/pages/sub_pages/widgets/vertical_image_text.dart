import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class SVerticalImageTextWidget extends StatelessWidget {
  const SVerticalImageTextWidget(
      {super.key,
      required this.categoryType,
      required this.image,
      this.textColor = kWhite,
      this.backgroundColor,
      this.onTap});
  final String categoryType; // Update type to String
  final String image;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    //final dark = SHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Column(
          children: [
            //
            //CircularIcon
            Container(
              width: 100,
              height: 100,
              //padding: EdgeInsets.all(SSizes.sm),
              //decoration: BoxDecoration(
              // color:
              //  backgroundColor ?? (dark ? Colors.black : Colors.white),
              //borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            //Text

            SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  categoryType,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
