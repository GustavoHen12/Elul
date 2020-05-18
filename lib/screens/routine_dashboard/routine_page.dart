import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_services.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/screens/widgets/routine/card.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Routpage extends StatelessWidget {
  //LocalStorageService service = new LocalStorageService();
  @override
  Widget build(BuildContext context) => Provider<RoutineController>(
      create: (_) => RoutineController(),
      child: RoutinePage() 
    );
}


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
    SizeConfig().init(context);
    var activiti = new RoutineModel();
    final list = Provider.of<RoutineController>(context);

    // list.add(model);
    // list.add(model);
    // print(list);
    // list.cleanAll();
    // print(list);
    //expect(routine.list, model);

    // RoutineCard(
    //           title: 'Universidade',
    //           start: 12.00,
    //           end: 15.55,
    //           days: ["Sunday", "Monday", "Tuesday"])

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

  dialogBox ([RoutineModel model])
  {
    model = model ?? RoutineModel();
    
    Widget _titleInput(){
      return Container( 
        child: TextField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: theme.theme.primaryColor, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: theme.theme.accentColor, width: 1.5)),
            labelText: 'Activiti'),
          maxLength: 20,
          style: theme.theme.textTheme.button,
          )
        );
    }
    
    Widget _timeInput() {
      TimeOfDay startTime = TimeOfDay.now();
      TimeOfDay endTime = TimeOfDay.now();

      _pickTime(time) async {
      TimeOfDay t = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
        );
        if(t != null)
            return time;
      }

      //formata
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formaStartTime = localizations.formatTimeOfDay(startTime, alwaysUse24HourFormat: false);
      String formaendTime = localizations.formatTimeOfDay(endTime, alwaysUse24HourFormat: false);
      
      return Row(
        children: [
          Flexible(child: 
          ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal:5),
              title: Text("Start: $formaStartTime"),
              onTap: ()async {
                startTime = await _pickTime(startTime);},
            )),
          Flexible(child:
          ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal:5),
              title: Text("End: $formaendTime"),
              onTap: ()async {
                startTime = await _pickTime(endTime);},
            )),
        ]);
    }

    Widget _daysInput() {
      List ndays = ['Monday', 'Tuesday'];
      var boolDays = {'Sunday': false, 'Monday':false, 'Tuesday': false, 
                    'Wednesday': false, 'Thursday': false, 'Friday': false, 'Saturday': false};
      ndays.forEach((element) {boolDays[element] = true;});
      return Container(
        child: Wrap(
          spacing: 5.0,
          children: <Widget>[
            FilterChip(
              label: Text('Sun'),
              selected: boolDays['Sunday'],
              onSelected: (bool selected) { boolDays['Sunday'] = !boolDays['Sunday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
            FilterChip(
              label: Text('Mon'),
              selected: boolDays['Monday'],
              onSelected: (bool selected) { boolDays['Monday'] = !boolDays['Monday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
            FilterChip(
              label: Text('Tue'),
              selected: boolDays['Tuesday'],
              onSelected: (bool selected) { boolDays['Tuesday'] = !boolDays['Tuesday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
            FilterChip(
              label: Text('Wed'),
              selected: boolDays['Wednesday'],
              onSelected: (bool selected) { boolDays['Wednesday'] = !boolDays['Wednesday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
            FilterChip(
              label: Text('Thu'),
              selected: boolDays['Thursday'],
              onSelected: (bool selected) { boolDays['Thursday'] = !boolDays['Thursday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
            FilterChip(
              label: Text('Fri'),
              selected: boolDays['Friday'],
              onSelected: (bool selected) { boolDays['Friday'] = !boolDays['Friday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
            FilterChip(
              label: Text('Sat'),
              selected: boolDays['Saturday'],
              onSelected: (bool selected) { boolDays['Saturday'] = !boolDays['Saturday'];},
              selectedColor: Theme.of(context).accentColor,
            ),
          ],),
      );
    }

    Widget _buttons()
    {
      return Container(
        margin: EdgeInsets.only(top: 25),
        width: double.infinity,
        child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(child: Text('Save', style: theme.theme.textTheme.headline5,), onPressed: (){},),
          FlatButton(child: Text('Cancel', style: theme.theme.textTheme.headline5), onPressed: (){},),
        ],),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return 
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: (17*SizeConfig.blockSizeVertical)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 25,
          child: Center (
            child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _titleInput(),
                _timeInput(),
                _daysInput(),
                _buttons(),
              ],),
        )));
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
