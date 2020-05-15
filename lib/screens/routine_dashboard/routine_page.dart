import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RoutinePage extends StatefulWidget {
  
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  ThemeStore theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme ??= Provider.of<ThemeStore>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: theme.toggleTheme,
        child: theme.isDark
            ? Icon(Icons.brightness_high)
            : Icon(Icons.brightness_2),
      ),

      body: new SafeArea(
        child: Column(
          children: <Widget>[
            _buildTop(),
            _buildList(),
            //_buildGrid(),
          ],)
        )
    );
  }

  List _days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  Widget _buildList()
  {
    return Expanded(
      child: ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20), 
              child: Text(_days[index], style: theme.theme.textTheme.headline3,),
            );
          }
        )
      );
  }

  Widget _buildTop()
  {
    return new Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(top:15, left: 15),
      child: RaisedButton(
        onPressed: (){},
        child: 
          Text("New Activity")
      , ) 
    );
  }
}
