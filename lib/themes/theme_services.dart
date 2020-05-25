import 'package:Elul/themes/theme_repository.dart';
import 'package:flutter/material.dart';

class ThemeService {
  ThemeService(IThemeRepository themeRepository)
      : _themeRepository = themeRepository;

  IThemeRepository _themeRepository;
  
  ThemeData get lightTheme => ThemeData(
        buttonColor: Colors.lightBlue,
        primarySwatch: Colors.lightBlue,
        accentColor: Color.fromARGB(255, 141, 169, 196),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        textTheme: TextTheme(
          //HEADLINE(Lato)
          headline3: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 25),
          headline4: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          headline5: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueAccent),
          //BODYTEXT(OpenSans)
          bodyText1: TextStyle(fontFamily: "OpenSans"),
          bodyText2: TextStyle(fontFamily: "OpenSans"),
          //SUBTITLE(OpenSans)
          subtitle1: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w800),
          //BUTTOM (Lato)
          button: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w700, fontSize: 15),
          
        )
      );

  ThemeData get darkTheme => ThemeData(
        buttonColor: Colors.white70,
        primarySwatch: Colors.lightBlue,
        accentColor: Color.fromARGB(255, 141, 169, 196),
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
        textTheme: TextTheme(
          //HEADLINE(Lato)
          headline3: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 25),
          headline4: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          headline5: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          //BODYTEXT(OpenSans)
          bodyText1: TextStyle(fontFamily: "OpenSans"),
          bodyText2: TextStyle(fontFamily: "OpenSans"),
          //SUBTITLE(OpenSans)
          subtitle1: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w800),

          button: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w700, fontSize: 15),
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