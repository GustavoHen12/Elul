import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RoutinePage extends StatefulWidget {
  
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {

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
}
