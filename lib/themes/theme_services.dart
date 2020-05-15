import 'package:Elul/themes/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  ThemeService(IThemeRepository themeRepository)
      : _themeRepository = themeRepository;

  IThemeRepository _themeRepository;
  
  ThemeData get lightTheme => ThemeData(

        primarySwatch: Colors.lightBlue,
        accentColor: Color.fromARGB(255, 141, 169, 196),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: "OpenSans"),
          headline3: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 24)
        )
      );

  ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightBlueAccent,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: "OpenSans"),
          headline3: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 24)
        )
      );

  Future<ThemeData> getTheme() async {
    final String themeKey = await _themeRepository.getThemeKey();

    if (themeKey == null) {
      await _themeRepository.setThemeKey(lightTheme.brightness);

      return lightTheme;
    } else {
      return themeKey == "light" ? lightTheme : darkTheme;
    }
  }

  Future<ThemeData> toggleTheme(ThemeData theme) async {
    if (theme == lightTheme) {
      theme = darkTheme;
    } else {
      theme = lightTheme;
    }

    await _themeRepository.setThemeKey(theme.brightness);
    return theme;
  }
}