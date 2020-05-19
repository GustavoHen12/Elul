import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';

class  DialogBox extends StatefulWidget {
  
  RoutineModel model;
  DialogBox ({this.model});

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  ThemeStore theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  @override
  void initState() { 
    super.initState();
    widget.model = widget.model ?? RoutineModel();  
  }
  
  
  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    var activiti = new RoutineModel();
    final list = Provider.of<RoutineController>(context);

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

    Widget _buttons(){
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
}