import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/tools/debouncer/app_debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin SearchWidgets {
  final TextEditingController searchBarController = TextEditingController();

  Widget searchBarContainer(Widget child, {
    EdgeInsets padding = const EdgeInsets.only(left: 25, bottom: 25, right: 25),
    EdgeInsets margin = EdgeInsets.zero,
  }) => Container(
      padding: padding,
      margin: margin,
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
    
  }) =>
      Row(children: [
        const Icon(
          Icons.search,
          size: 24,
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
