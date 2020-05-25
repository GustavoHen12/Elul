import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_services.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/screens/widgets/routine/card.dart';
import 'package:Elul/screens/widgets/routine/dialogBox.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';


// class Routpage extends StatelessWidget {
//   //LocalStorageService service = new LocalStorageService();
//   @override
//   Widget build(BuildContext context) => Provider<RoutineController>(
//       create: (_) => RoutineController(),
//       child: RoutinePage() 
//     );
// }


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
      floatingActionButton: FloatingActionButton(
        onPressed: theme.toggleTheme,
        child: theme.isDark
            ? Icon(Icons.brightness_high)
            : Icon(Icons.brightness_2),
      ),

      body: Observer(
        builder: (_)=>  new SafeArea(
        child: Column(
          children: <Widget>[
            _buildTop(),
            Container(child: Text(activities.itemsTotal.toString()),),
            ActivitiList(),
          ],)
        )
    ));
  }

  List _days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  Widget _buildList()
  {
    final activities = Provider.of<RoutineController>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index){
            List list = new List(); 
            //activities.list.where((item) => item.days.contains(_days[index]));
            activities.list.forEach((element) {
              if(element.days.contains(_days[index]))
                list.add(RoutineCard(activiti: element));
            });

            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20), 
                  child: Text(_days[index], style: theme.theme.textTheme.headline3,)
                ),
                SizedBox(
                height: (list.length * 120.0),
                child:
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index){
                    return list[index];
                  }))
            ]);
          }
        )
      );
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
  ActivitiList({Key key}) : super(key: key);

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
      child: ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index){
            List list = new List(); 
            //activities.list.where((item) => item.days.contains(_days[index]));
            activities.list.forEach((element) {
              if(element.days.contains(_days[index]))
                list.add(RoutineCard(activiti: element));
            });
            return Observer(
              builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20), 
                  child: Text(_days[index], style: theme.theme.textTheme.headline3,)
                ),
                SizedBox(
                height: (list.length * 120.0),
                child:
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index){
                    return list[index];
                  }))
            ]));
            }
        )
      );
  }
}