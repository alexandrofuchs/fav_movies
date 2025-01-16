import 'package:fav_movies/core/helpers/extensions/list_extension.dart';

enum MovieLanguage {
  en('en', 'inglês'),
  pt('pt', 'português'),
  es('es', 'espanhol'),
  fr('fr', 'francês'),
  de('de', 'alemão'),
  it('it', 'italiano'),
  ja('ja', 'japonês'),
  zh('zh', 'chinês'),
  ru('ru', 'russo'),
  ar('ar', 'árabe'),
  unknown('none', 'desconhecida');
  
  const MovieLanguage(this.value, this.label);

  final String value;
  final String label;
  
  factory MovieLanguage.fromValue(String value) {

    if(value.isEmpty){
      print(value);
    }

    return MovieLanguage.values.firstWhereOrNull((e) => e.value == value) ?? MovieLanguage.unknown;}
}