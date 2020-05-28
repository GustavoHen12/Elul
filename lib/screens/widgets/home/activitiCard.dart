import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiCard extends StatefulWidget {
  final RoutineModel activiti;
  ActivitiCard({@required this.activiti});

  @override
  _ActivitiCardState createState() => _ActivitiCardState();
}

class _ActivitiCardState extends State<ActivitiCard> {

  ThemeStore theme;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  double _getHeight()
  {
    int hours = int.parse(widget.activiti.endTime.substring(0, 2)) -
                int.parse(widget.activiti.startTime.substring(0, 2));
    int minutes = int.parse(widget.activiti.endTime.substring(3, 4)) -
            int.parse(widget.activiti.startTime.substring(3, 4)); 
    double size = ((SizeConfig.blockSizeVertical*12) * hours) +
                  ((SizeConfig.blockSizeVertical*2)* minutes) +
                  (SizeConfig.blockSizeVertical*6);
    return size;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child:
        Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        borderOnForeground: false,
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: _getHeight(),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              _getHeader(widget.activiti.title,
                          widget.activiti.startTime,
                          widget.activiti.endTime),
              //_buildTodoView()
            ]
          ),
        )
      )
    );
  }

  Widget _getHeader(String title, String start, String end)
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      height: SizeConfig.blockSizeVertical*6,
      child: Column(
        children: [
        Container(
          alignment: Alignment.bottomRight,
          child:
            Text(title, style:theme.theme.textTheme.button),),
        Container(
          alignment: Alignment.bottomRight,
          child: 
            Text('$start - $end', style: theme.theme.textTheme.bodyText2,))
        ]),
    );

  }
}