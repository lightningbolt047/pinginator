import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinginator/config.dart';

void setDarkThemePreference(bool value) async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setBool('darkTheme', value);
}

Future<bool> getDarkThemePreference() async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  if(pref.getBool('darkTheme')==null){
    themeManager.setDarkThemeValue(false);
    pref.setBool('darkTheme', themeManager.getDarkThemeValue());
  }
  themeManager.setDarkThemeValue(pref.getBool('darkTheme'));
  return themeManager.getDarkThemeValue();
}

void setGamePreference(String value) async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('gameName',value);
}

Future<String> getGamePreference() async{
  SharedPreferences pref=await SharedPreferences.getInstance();

  if(pref.getString('gameName')==null){
    pref.setString('gameName', 'Fortnite');
    gamePreferences.setGameName("Fortnite");
    return gamePreferences.getGameName();
  }
  gamePreferences.setGameName(pref.getString('gameName'));
  return gamePreferences.getGameName();
}
