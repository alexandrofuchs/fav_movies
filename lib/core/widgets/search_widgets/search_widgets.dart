import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/tools/debouncer/app_debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin SearchWidgets {
  final TextEditingController searchBarController = TextEditingController();

  Widget searchBarContainer(Widget child) => Container(
      padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
      decoration: const BoxDecoration(
        color: AppColors.primaryColorDark,
      ),
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.only(left: 15),
          child: child));

  Widget searchBar(
    String label,
    void Function(String value) debounceAction, {
    bool autofocus = false,
    Key? key,
    void Function()? onClearText,
    EdgeInsets padding =
        const EdgeInsets.only(left: 25, right: 25, bottom: 5, top: 5),
    EdgeInsets margin = const EdgeInsets.only(right: 25, left: 25, top: 15),
  }) =>
      Row(children: [
        const Icon(
          Icons.search,
          size: 24,
          color: AppColors.secundaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
            child: TextFormField(
          key: key,
          controller: searchBarController,
          autofocus: autofocus,
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.secundaryColor),
          onChanged: (value) {
            Modular.get<AppDebouncer>().handleTextFieldChange(
                const Duration(milliseconds: 500), value, debounceAction);
          },
          decoration: InputDecoration(
              hintText: label,
              hintStyle: AppTextStyles.labelSmall,
              border: const UnderlineInputBorder(borderSide: BorderSide.none)),
        )),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(
            Icons.cancel,
            size: 24,
            color: AppColors.secundaryColor,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            searchBarController.text = '';
            Modular.get<AppDebouncer>().handleTextFieldChange(
                const Duration(milliseconds: 500),
                searchBarController.text,
                debounceAction);
            if (onClearText != null) onClearText();
          },
        )
      ]);
}
