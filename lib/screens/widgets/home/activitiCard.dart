import 'package:Elul/models/routineModel.dart';
import 'package:Elul/models/timeStr.dart';
import 'package:Elul/models/taskModel.dart';
import 'package:Elul/screens/home/home_store.dart';
import 'package:Elul/screens/widgets/home/dialogBoxTask.dart';
import 'package:Elul/screens/widgets/home/tasks.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActivitiCard extends StatefulWidget {
  final RoutineModel activiti;
  final DateTime day;
  ActivitiCard({@required this.activiti, @required this.day});

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

  //com base na duração da atividade, retorna o tamanho que esta deve ter
  //ele faz o calculo de dois tamanhos um com base na quantidade de atividades
  //outro com base na duracao da atividade
  //retorna o maior
  double _getHeight(List tasks)
  {
    int count = 0;

    tasks.forEach((element) {
      if(element.activitie == widget.activiti.title)
        count++;
    });

    double nsize = count*45.0 + 10;

    Time_Str timeConfig = new Time_Str();

    TimeOfDay start = timeConfig.toTime(widget.activiti.startTime);
    TimeOfDay end = timeConfig.toTime(widget.activiti.endTime);
    int hours = end.hour - start.hour;
    int minutes = end.minute - start.minute; 

    double size = ((SizeConfig.blockSizeVertical*12) * hours) +
                  ((SizeConfig.blockSizeVertical*0.5)* minutes) +
                  (SizeConfig.blockSizeVertical*6);

    if(size > nsize)
      return size;
    return nsize;
  }

  dialogBox ({@required String activiti, TaskModel todo, @required String day})
  {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return new DialogBoxTask(activiti: activiti, todo: todo, day: day);  
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<HomeController>(context);
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: 
      GestureDetector(
        onTap: (){
          dialogBox(activiti: widget.activiti.title, day: DateFormat('EEE, d MMMM').format(widget.day));
        },
        child:
          Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          borderOnForeground: false,
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child:
            Observer(builder: (_)=>
            SizedBox(
              height: _getHeight(taskList.list),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  //header do card (titulo da atividade e horario)
                  _getHeader(widget.activiti.title,
                              widget.activiti.startTime,
                              widget.activiti.endTime),
                  Observer(
                    builder: (_)=>
                      BuildTasks(
                        tasks: taskList.list,
                        activiti: widget.activiti.title,
                        day: widget.day),
                  )
                ]
              ),
            )
          )
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style:theme.theme.textTheme.button),
          Text('$start - $end', style: theme.theme.textTheme.bodyText2,)
      ]),
    );

  }
}