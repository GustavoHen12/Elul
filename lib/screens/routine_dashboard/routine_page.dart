import 'package:Elul/icons/elul_icons_icons.dart';
import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/screens/widgets/routine/card.dart';
import 'package:Elul/screens/widgets/routine/dialogBoxActiviti.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';



class RoutinePage extends StatefulWidget {
  
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

/*
 * PARTE PRINCIPAL DA PAGINA,
 * Configura a navbar e o floatButton
 */
class _RoutinePageState extends State<RoutinePage> {
  ThemeStore theme;
  final RoutineController activities =  RoutineController();
  
  @override
  Widget build(BuildContext context) {
    theme ??= Provider.of<ThemeStore>(context);
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: theme.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(ElulIcons.backarrow_icon, size: 22,color: theme.theme.buttonColor,), 
          onPressed:(){Navigator.pop(context);},
          ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dialogBox();
        },
        child: Icon(ElulIcons.add_icon, size: 25, color: theme.theme.iconTheme.color),
      ),

      body: 
        new SafeArea(
        child:
            //lista com os dias e atividades
            ActivitiList(),
    ));
  }

  dialogBox ([RoutineModel model])
  {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return new DialogBoxActiviti(activiti: model);  
      }
    );
  }
}

/*
 * Constroi os dias
 */
class ActivitiList extends StatefulWidget {
  @override
  _ActivitiListState createState() => _ActivitiListState();
}

class _ActivitiListState extends State<ActivitiList> {

  ThemeStore theme;
  final RoutineController activities =  RoutineController();

  List _days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
  @override
  Widget build(BuildContext context) {
    theme ??= Provider.of<ThemeStore>(context);
    final activities = Provider.of<RoutineController>(context);
    return Expanded(
      child: 
      ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index){
            //constroi as atividades dos dias
            return BuildDay(day: _days[index], activities: activities.list);
        }
      ));
  }
}

/*
 * Constroi os cards de atividades para cada dia
 */
class BuildDay extends StatefulWidget {
  final String day;
  final List activities;
  BuildDay({@required this.day, @required this.activities});

  @override
  _BuildDayState createState() => _BuildDayState();
}

class _BuildDayState extends State<BuildDay> {
  ThemeStore theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }
  //calcula o a altura necessaria para colocar todos os card do dia
  _getSizeH()
  {
    int quant = 0;
    widget.activities.forEach((element) {
      if(element.days.contains(widget.day))
        quant++;
    });
    return quant * 120.0;
  }
  @override
  Widget build(BuildContext context) { 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20), 
          child: Text(widget.day, style: theme.theme.textTheme.headline3,)
        ),
        Observer(
          builder: (_)=>
            SizedBox(
            height: _getSizeH(),
            child: 
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.activities.length,
              itemBuilder: (context, index){
                  if(widget.activities[index].days.contains(widget.day))
                      return RoutineCard(activiti: widget.activities[index]);
                  else 
                      return Container();
              })),)
    ]);
  }
}