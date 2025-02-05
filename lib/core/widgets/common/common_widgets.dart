import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';

mixin CommonWidgets {
  Widget loadingWidget(String label) => Container(
        margin: const EdgeInsets.all(25),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Text(
              label,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Widget errorMessageWidget(String label) => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 45, color: Colors.red),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelMedium,
            )
          ],
        ),
      );

  Widget titleDot(String text,) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.all(15),
            decoration: const ShapeDecoration(shape: BeveledRectangleBorder(borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5)
              )),
              color:   AppColors.orangeColor,
            )),
          Flexible(
              child: Text(
            text,
            style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w500),
            softWrap: true,
          )),
        ],
      );

  Widget itemDot(String text, {bool bold = false}) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 10,
              height: 10,
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
                child: Text(
              text,
              style: AppTextStyles.bodyMedium
                  .copyWith(fontWeight: FontWeight.w700),
              softWrap: true,
            )),
          ],
        ),
      );

  Widget infoRow(String label, String text,
          {EdgeInsets padding = const EdgeInsets.only()}) =>
      Padding(
        padding: padding,
        child: RichText(
          softWrap: true,
          maxLines: 2,
          text: TextSpan(
            style: AppTextStyles.labelSmall,
            children: <TextSpan>[
              TextSpan(
                  text: label,
                  style: const TextStyle(fontWeight: FontWeight.w400, color: AppColors.primaryColorLight)
                  ),
              TextSpan(text: text,),
            ],
          ),
        ),
      );

  Widget divider() => const Padding(
    padding: EdgeInsets.only(top: 15),
    child: Divider(
          color: AppColors.orangeColor,
          height: 2,
          thickness: 0.3,
          indent: 1,
          endIndent: 3,
        ),
  );
}
