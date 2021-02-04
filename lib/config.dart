import 'package:flutter/material.dart';
import 'content.dart';

int maxMeetingID=99999999;


class ThemeManager with ChangeNotifier{
  bool _darkTheme=false;

  Color homeScreenBottomContainerColor,currentSecondaryColor=gameMap[gamePreferences.getGameName()]['themeColor'];



  ThemeMode getCurrentThemeMode(){
    return _darkTheme?ThemeMode.dark:ThemeMode.light;
  }

  void setDarkThemeValue(bool value){
    _darkTheme=value;
    //TODO Implement fragmented color variables here
    homeScreenBottomContainerColor=this.getDarkThemeValue()?Colors.black:Colors.white;
    notifyListeners();
  }

  bool getDarkThemeValue(){
    return _darkTheme;
  }

  ThemeData getCurrentThemeData(){
    return _darkTheme?getDarkTheme():getLightTheme();
  }


  ThemeData getDarkTheme(){
    return ThemeData.dark().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: gameMap[gamePreferences.getGameName()]['themeColor'],
          foregroundColor: Colors.white,
          elevation: 5,
        ),
        toggleableActiveColor: gameMap[gamePreferences.getGameName()]['themeColor'],
        dialogBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        accentColor: Colors.purpleAccent,
        cardColor: Colors.grey[900],
        // colorScheme: ColorScheme.dark(),
        scaffoldBackgroundColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        bottomAppBarColor: Colors.black,
        backgroundColor: Colors.black,
    );
  }

  ThemeData getLightTheme(){
    return ThemeData.light().copyWith(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: gameMap[gamePreferences.getGameName()]['themeColor'],
          foregroundColor: Colors.white
      ),
      accentColor: gameMap[gamePreferences.getGameName()]['themeColor'],
      primaryColor: Colors.white,
      backgroundColor: Colors.black,
    );
  }
}


class GamePreferences with ChangeNotifier{
  String _gameName;
  void setGameName(String value){
    _gameName=value;
  }
  String getGameName(){
    return _gameName;
  }
}

int maxNumPings=5;


ThemeManager themeManager=ThemeManager();
GamePreferences gamePreferences=GamePreferences();