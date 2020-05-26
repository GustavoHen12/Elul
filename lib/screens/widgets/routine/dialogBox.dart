import 'package:Elul/models/routineModel.dart';
import 'package:Elul/models/timeStr.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';

class  DialogBox extends StatefulWidget {
  
  RoutineModel activiti;
  //BuildContext context;
  //final RoutineController list;
  DialogBox ({this.activiti});

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  ThemeStore theme;

  //dados que serao atualizados 
  String _title;
  List _days;
  String _start;
  String _end;

  //converte de TimeOf Day para String e vice versa
  Time_Str timeConverter = new Time_Str();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }
  //para o text field de titulo
  final _textController = TextEditingController();

  RoutineModel activiti = new RoutineModel();
  
  @override
  void initState() { 
    super.initState();
    //se não for passado um RoutineModel existente
    //ou seja, se é um novo ou um ja existente
    activiti = widget.activiti ?? RoutineModel();
    _textController.text = activiti.title;
    if(widget.activiti != null)
    {
      _title = widget.activiti.title;
      _days = widget.activiti.days;
      _start = widget.activiti.startTime;
      _end = widget.activiti.endTime;
    } 
  }
  
  
  @override
  Widget build(BuildContext _context){  
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
          _title = value;
        },
        )
      );
  }

  Widget _timeInput() {
    //se for null, ou seja, um horario novo, inicia com a hora atual
    _start = _start ?? timeConverter.toStr(TimeOfDay.now());
    _end = _end ?? timeConverter.toStr(TimeOfDay.now());
    // MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Row(
      children: [
        Flexible(child: 
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal:5),
            title: Text("Start: $_start"),
            onTap: ()async{
              //aguarda resposta do horario selecionado
              TimeOfDay newTime = await showTimePicker(
                context: context,
                //horario inicial
                initialTime: TimeOfDay.now(),
                //para sempre usar o formato de 24h, ao inves de periodos de 12h com am e pm
                builder: (BuildContext context, Widget child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                    child: child,
                  );
                },
              );
              if(newTime != null)
                setState(() {
                  _start = timeConverter.toStr(newTime);
                });
            }
          )),
        Flexible(child:
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal:5),
            title: Text("End: $_end"),
            onTap: ()async {
              TimeOfDay newTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                    child: child,
                  );
                }
              );
              if(newTime != null)
                setState(() {
                  _end = timeConverter.toStr(newTime);
                });
            },
          )),
      ]);
  }

  Widget _daysInput() {
    _days ??= new List();
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
            selected: _days.contains(day),
            onSelected: (bool selected) {
              setState(() {
                if(selected)
                  _days.add(day);
                else
                  _days.remove(day);
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
    RoutineModel routine = RoutineModel(days: _days, title: _title, startTime: _start, endTime: _end);
    final list = Provider.of<RoutineController>(context, listen: false);
    if(widget.activiti == null)
    {
      await list.add(routine);
    }
    else
    {
      widget.activiti.days = _days; 
      widget.activiti.title = _title; 
      widget.activiti.startTime = _start; 
      widget.activiti.endTime = _end;
      await list.update(activiti);
    }
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