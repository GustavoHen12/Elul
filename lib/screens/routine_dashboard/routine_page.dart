import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/screens/widgets/routine/card.dart';
import 'package:Elul/screens/widgets/routine/dialogBox.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';



class RoutinePage extends StatefulWidget {
  
  @override
  _RoutinePageState createState() => _RoutinePageState();
}


class _RoutinePageState extends State<RoutinePage> {
  ThemeStore theme;
  final RoutineController activities =  RoutineController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }


  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<RoutineController>(context);
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 244, 237),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30,), 
          onPressed:(){Navigator.pop(context);},
          ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dialogBox();
        },
        child: Icon(Icons.add, size: 35,),
      ),

      body: 
        //Observer(
        //builder: (_)=>  
        new SafeArea(
        child: Column(
          children: <Widget>[
            //_buildTop(),
          //  Container(child: Text(activities.itemsTotal.toString()),),
            ActivitiList(),
          ],)
      //  )
    ));
  }

  dialogBox ([RoutineModel model])
  {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return new DialogBox(activiti: model);  
      }
    );
  }

  Widget _buildTop()
  {
    return new Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(top:15, right: 20),
      child: RaisedButton(
        padding: EdgeInsets.all(8),
        onPressed: (){
          dialogBox();
        },
        child: 
          Row( mainAxisSize: MainAxisSize.min,
            children:[
            Icon(Icons.add),
            Text("New Activity")
      , ])) 
    );
  }
}


class ActivitiList extends StatefulWidget {
  @override
  _ActivitiListState createState() => _ActivitiListState();
}

class _ActivitiListState extends State<ActivitiList> {

  ThemeStore theme;
  final RoutineController activities =  RoutineController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  List _days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<RoutineController>(context);
    return Expanded(
      child: 
      // Observer(
      // builder: (_) => 
      ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index){
            return BuildDay(day: _days[index], activities: activities.list);
            }
        //)
      ));
  }
}

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
    //final activities = Provider.of<RoutineController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20), 
          child: Text(widget.day, style: theme.theme.textTheme.headline3,)
        ),
        Observer(builder: (_)=>
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