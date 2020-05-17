import 'package:Elul/screens/routine_dashboard/routine_page.dart';
import 'package:Elul/themes/theme_repository.dart';
import 'package:Elul/themes/theme_services.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter_test/flutter_test.dart';
//initializeDateFormatting('pt_BR', null);
void main() async { 
  print('object');
  //TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // final directory = await path_provider.getApplicationDocumentsDirectory();
  // print(directory.path);
  // Hive.init(directory.path);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(
            create: (_) =>
                ThemeStore(ThemeService(ThemeRepository()))..getTheme())
      ],
      child: Consumer<ThemeStore>(
        builder: (_, ThemeStore value, __) => Observer(
          builder: (_) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Elul',
            theme: value.theme,
            home: Routpage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 244, 237),
      body: new SafeArea(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            //_buildGrid(),
          ],)
        )
    );
  }

  Widget _buildHeader()
  {
    var date = DateTime.now();

    String _day = 'Today';
    String _date = DateFormat('E, d MMM').format(date);

    return new Container(
      margin: EdgeInsets.only(top:15, left: 15),
      child: Column(
        children: <Widget>[
          Container(child:
          Text(_date, style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromARGB(255, 141, 169, 196))
          ))),
          Container( child:
          Text(_day, style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 34,
                        color: Color.fromARGB(255, 11, 37, 69)) 
          )))
        ],)
    );
  }

  // Widget _buildGrid()
  // {
  //   return Container(child: Text('test'),);
  // }
}
