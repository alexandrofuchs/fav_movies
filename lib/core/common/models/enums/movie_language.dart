import 'package:fav_movies/core/helpers/extensions/list_extension.dart';

enum MovieLanguage {
  en('en', 'inglês'),
  pt('pt', 'português'),
  es('es', 'espanhol'),
  unknown('none', 'desconhecida');

  const MovieLanguage(this.value, this.label);

  final String value;
  final String label;
  
  factory MovieLanguage.fromValue(String value) =>
    MovieLanguage.values.firstWhereOrNull((e) => e.value == value) ?? MovieLanguage.unknown;
}