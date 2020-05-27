import 'package:Elul/screens/home/home_page.dart';
import 'package:Elul/screens/routine_dashboard/routine_page.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/themes/theme_repository.dart';
import 'package:Elul/themes/theme_services.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

//initializeDateFormatting('pt_BR', null);
void main() async {
  //TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(
            create: (_) =>
                ThemeStore(ThemeService(ThemeRepository()))..getTheme()),
        Provider<RoutineController>(
           create: (_) => RoutineController()),
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