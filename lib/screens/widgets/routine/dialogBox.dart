import 'package:Elul/models/routineModel.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';

class DialogBox extends StatelessWidget {
  RoutineModel activiti;
  DialogBox ([this.activiti]);
  @override
  Widget build(BuildContext context) => Provider<RoutineController>(
      create: (_) => RoutineController(),
      child: _DialogBox(activiti) 
    );
}

class  _DialogBox extends StatefulWidget {
  
  RoutineModel activiti;
  _DialogBox ([this.activiti]);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<_DialogBox> {
  ThemeStore theme;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }
  
  final _textController = TextEditingController();
  RoutineModel activiti;
  @override
  void initState() { 
    super.initState();
    activiti = widget.activiti ?? RoutineModel();
    _textController.text = activiti.title;  
  }
  
  
  @override
  Widget build(BuildContext context){  
    SizeConfig().init(context);

    return Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: (16*SizeConfig.blockSizeVertical)),
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

    Widget _titleInput(){
      return Container( 
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: theme.theme.primaryColor, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: theme.theme.accentColor, width: 1.5)),
            labelText: 'Activiti'),
          maxLength: 20,
          style: theme.theme.textTheme.button,
          onChanged: (String value){
            activiti.title = value;
          },
          )
        );
    }

    Widget _timeInput() {
      TimeOfDay startTime = activiti.startTime ?? TimeOfDay.now();
      TimeOfDay endTime = activiti.endTime ?? TimeOfDay.now();

      // //formata
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formaStartTime = localizations.formatTimeOfDay(startTime, alwaysUse24HourFormat: false);
      String formaendTime = localizations.formatTimeOfDay(endTime, alwaysUse24HourFormat: false);
      
      return Row(
        children: [
          Flexible(child: 
          ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal:5),
              title: Text("Start: $formaStartTime"),
              onTap: ()async{
                TimeOfDay newTime = await showTimePicker(
                  context: context,
                  initialTime: activiti.startTime ?? TimeOfDay.now(),
                );
                if(newTime != null)
                  setState(() {
                    activiti.startTime = newTime;
                  });
              }
            )),
          Flexible(child:
          ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal:5),
              title: Text("End: $formaendTime"),
              onTap: ()async {
               TimeOfDay newTime = await showTimePicker(
                  context: context,
                  initialTime: activiti.endTime ?? TimeOfDay.now(),
                );
                if(newTime != null)
                  setState(() {
                    activiti.endTime = newTime;
                  });
              },
            )),
        ]);
    }

    Widget _daysInput() {
      activiti.days ??= new List();
      return Flexible(
        child: Container(
        child: Wrap(
          spacing: 3.0,
          children: [
            'Sunday',
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday'
          ]
            .map((day) => FilterChip(
              label: Text(day.substring(0, 3)),
              selected: activiti.days.contains(day),
              onSelected: (bool selected) {
                setState(() {
                  if(selected)
                    activiti.days.add(day);
                  else
                    activiti.days.remove(day);
                });
              }, 
              selectedColor: Theme.of(context).accentColor,
              )
            )
            .toList(),
          ),
      ));
    }

    _save() async {
      final list = Provider.of<RoutineController>(context, listen: false);
      if(widget.activiti == null)
        await list.add(activiti);
      else
        await list.update(activiti);
    }

    _back(){
      Navigator.pop(context);
    }
    Widget _buttons(){
      return Container(
        margin: EdgeInsets.only(top: 25),
        width: double.infinity,
        child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(child: Text('Save', style: theme.theme.textTheme.headline5,), 
          onPressed: (){
            _save();
            _back();
          },),
          FlatButton(child: Text('Cancel', style: theme.theme.textTheme.headline5), 
          onPressed: (){
            _back();
          },),
        ],),
      );
    }
}