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
            )
          ],
        ),
      );

  Widget titleDot(String text, [bool lightDot = false]) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: lightDot ? AppColors.secundaryColor : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 24,
            height: 24,
          ),
          Flexible(
              child: Text(
            text,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            softWrap: true,
          )),
        ],
      );

  Widget itemDot(String text, {bool bold = false}) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 50, right: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 10,
            height: 10,
          ),
          Flexible(
              child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
            softWrap: true,
          )),
        ],
      );
}
