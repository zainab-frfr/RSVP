import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rsvp/themes/darkmode.dart';
import 'package:rsvp/themes/lightmode.dart';

class ThemeProvider extends ChangeNotifier{

  final Box box = Hive.box('myBox');
  String strTheme = 'light';

  ThemeData _theme = lightmode; 

  void _saveTheme(){
    box.put('theme', strTheme);
  }

  ThemeData loadTheme(){
    strTheme = box.get('theme', defaultValue: 'light');

    if(strTheme == 'light'){
      _theme = lightmode;
    }else{
      _theme = darkmode;
    }
    return _theme;
  }

  ThemeData getThemeData() => _theme;

  void toggleTheme(){
    if (_theme == lightmode){
      _theme = darkmode;
      strTheme = 'dark';
    }else{
      _theme = lightmode;
      strTheme = 'light';
    }
    _saveTheme();
    notifyListeners();
  }

  bool isDarkMode() => _theme == darkmode;
}