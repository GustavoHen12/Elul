import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IThemeRepository {
  Future<String> getThemeKey();
  Future<void> setThemeKey(Brightness brightness);
}

class ThemeKey {
  static const String THEME = "theme";
}

class ThemeRepository implements IThemeRepository {

  @override
  Future<void> setThemeKey(Brightness brightness) async {
    (await SharedPreferences.getInstance()).setString(
      ThemeKey.THEME,
      brightness == Brightness.light ? "light" : "dark",
    );
  }

  @override
  Future<String> getThemeKey() async {
   // SharedPreferences.setMockInitialValues({});
    return (await SharedPreferences.getInstance()).getString(ThemeKey.THEME);
  }
}