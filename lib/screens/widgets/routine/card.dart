import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutineCard extends StatefulWidget
{
  final String title;
  final TimeOfDay start;
  final TimeOfDay end;
  final days;
  RoutineCard({this.title, this.start, this.end, this.days});

  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  ThemeStore mainTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainTheme ??= Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _title(widget.title),
              _time(widget.start, widget.end),
              _days(widget.days),
            ],),
        )
      ) 
    );
  }

  Widget _title(String title)
  {
    return Container(
      child: Text(title, style: mainTheme.theme.textTheme.headline4),
    );
  }

  Widget _time(TimeOfDay start, TimeOfDay end)
  {
    // var minutes = (start - start.truncate())*100;
    // var minutesEnd = (end - end.truncate())*100;
    // String date = start.toInt().toString()+':'+ minutes.toInt().toString() + 'h' +
    //               ' - '
    //               + end.toInt().toString()+':'+ minutesEnd.toInt().toString() + 'h';
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String startTime = localizations.formatTimeOfDay(start, alwaysUse24HourFormat: false);
    String endTime = localizations.formatTimeOfDay(end, alwaysUse24HourFormat: false);
      
    return Container( 
      margin: EdgeInsets.only(top: 5, bottom: 2),
      child: Text('$startTime - $endTime', style: mainTheme.theme.textTheme.bodyText2),
    );
  }

  Widget _days(List days)
  {
    String dayslist = "";
    days.forEach((element) {
      String day = element.substring(0, 3);
      dayslist = dayslist + ', ' + day;
    });

    return Container(
 //     margin: EdgeInsets.only(left: 10),
      child: Text(dayslist.substring(2, dayslist.length), style: mainTheme.theme.textTheme.bodyText2),
    );
  }
}