import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/screens/widgets/routine/dialogBoxActiviti.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutineCard extends StatefulWidget
{
  RoutineModel activiti;
  RoutineCard({this.activiti});

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
  final activities = Provider.of<RoutineController>(context, listen: false);
  
  return GestureDetector(
    onTap: (){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return new DialogBoxActiviti(activiti: widget.activiti);  
        }
      );
    },
    child:
      Card(
        borderOnForeground: false,
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _title(widget.activiti.title),
                    _time(widget.activiti.startTime, widget.activiti.endTime),
                    _days(widget.activiti.days),
                  ],),
                Container(child: 
                  IconButton(icon: Icon(Icons.delete_outline, 
                                        color: mainTheme.isDark ? Colors.white54 : Colors.grey[400],), 
                                        onPressed: ()async{
                                                      await activities.remove(widget.activiti.id);
                                                      }
                  ),
                ),
              ])
          )
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

  Widget _time(String start, String end)
  {
    return Container( 
      margin: EdgeInsets.only(top: 5, bottom: 2),
      child: Text('$start - $end', style: mainTheme.theme.textTheme.bodyText1),
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
      child: Text(dayslist.substring(2, dayslist.length), style: mainTheme.theme.textTheme.bodyText1),
    );
  }
}