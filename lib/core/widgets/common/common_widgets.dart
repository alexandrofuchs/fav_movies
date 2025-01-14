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
}
