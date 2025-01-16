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
  lv('lv', 'Latviano'),
  sv('sv', 'Latviano'),
  ru('ru', 'russo'),
  tr('tr', 'turco'),
  sh('sh', 'britânico'),
  hi('hi', 'havaiano'),
  nl('nl', 'holandês'),
  ko('ko', 'coréia do sul'),
  ar('ar', 'árabe'),
  th('th', 'tailandês'),
  tl('tl', 'tétum'),
  cn('cn', 'chinês'),
  cs('cs', 'checo'),
  da('da', 'dinamarques'),
  pl('pl', 'polonês'),
  iss('is', 'israelence'),
  te('te', 'télugo'),
  mk('mk', 'macedônio'),
  mr('mr', 'marata'),
  ca('ca', 'catalão'),
  hr('hr', 'croata'),
  zu('zu', 'zulu'),
  no('no', 'norwegian'),
  unknown('none', 'desconhecida');
  
  const MovieLanguage(this.value, this.label);

  final String value;
  final String label;
  
  factory MovieLanguage.fromValue(String value) {

    
    if(MovieLanguage.values.firstWhereOrNull((e)=> e.value.contains(value)) == null){
      print(value);
    }
    
    
    return MovieLanguage.values.firstWhereOrNull((e) => e.value.contains(value)) ?? MovieLanguage.unknown;}
}