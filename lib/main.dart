import 'package:Elul/screens/home/home_page.dart';
import 'package:Elul/screens/home/home_store.dart';
import 'package:Elul/screens/routine_dashboard/routine_page.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/themes/theme_repository.dart';
import 'package:Elul/themes/theme_services.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

//initializeDateFormatting('pt_BR', null);
void main() async {
  //TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //utilizamos o provider, para fazer a "ligacao" com os demais arquivos e MobX
    //Entao aqui e inserido os controllers na arvore
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(
            create: (_) =>
                ThemeStore(ThemeService(ThemeRepository()))..getTheme()),
        Provider<RoutineController>(
           create: (_) => RoutineController()),
        Provider<HomeController>(
            create: (_) => HomeController())
      ],
      child: Consumer<ThemeStore>(
        builder: (_, ThemeStore value, __) => Observer(
          builder: (_) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Elul',
            theme: value.theme,
            home: HomePage(),
          ),
        ),
      ),
    );
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff1b5299),
            Color(0xff8da9c4)
          ],
        ),
        navigateAfterSeconds: HomePage(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}