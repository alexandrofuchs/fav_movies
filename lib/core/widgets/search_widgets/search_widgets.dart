import 'package:fav_movies/core/tools/debouncer/app_debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin SearchWidgets {
  final TextEditingController searchBarController = TextEditingController();

  Widget searchBar(
    String label,
    void Function(String value) debounceAction, {
    bool autofocus = false,
    Key? key,
    EdgeInsets padding = const EdgeInsets.only(left: 25, right: 25, bottom: 5, top: 5),
    EdgeInsets margin = const EdgeInsets.only(right: 25, left: 25, top: 15),
  }) =>
      Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
              color: const Color(0xffd9d9d9),
              borderRadius: BorderRadius.circular(5)),
          child: Row(children: [
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
              onChanged: (value) {
                Modular.get<AppDebouncer>().handleTextFieldChange(
                    const Duration(milliseconds: 500), value, debounceAction);
              },
              decoration: InputDecoration(
                  hintText: label,
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none)),
            )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: const Icon(Icons.cancel, size: 24),
              padding: EdgeInsets.zero,
              onPressed: () {
                searchBarController.text = '';
                Modular.get<AppDebouncer>().handleTextFieldChange(
                    const Duration(milliseconds: 500), searchBarController.text, debounceAction);
              },
            )
          ]));
}
