import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppDebouncer extends Disposable {
  final Debouncer _debouncer = Debouncer();

  void handleTextFieldChange(
      Duration duration, String value, void Function(String) action) {
    _debouncer.debounce(
      duration: duration,
      onDebounce: () {
        action(value);
      },
    );
  }

  @override
  void dispose() {
    _debouncer.cancel();
  }
}
