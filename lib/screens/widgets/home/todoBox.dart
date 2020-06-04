import 'package:Elul/models/timeStr.dart';
import 'package:Elul/models/todoModel.dart';
import 'package:Elul/screens/home/home_store.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Elul/screens/widgets/sizeConfig.dart';

class  TodoBox extends StatefulWidget {
  
  String activiti;
  TodoModel todo;
  String day;
  TodoBox ({this.activiti, this.todo, this.day});

  @override
  _TodoBoxState createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  ThemeStore theme;

  //dados que serao atualizados 
  String _title;
  String _day;//recebe
  String _time = '';//pode ser null
  String _activitie;//recebe
  bool _check = false;//sai false

  //converte de TimeOf Day para String e vice versa
  Time_Str timeConverter = new Time_Str();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }
  //para o text field de titulo
  final _textController = TextEditingController();
  
  TodoModel _todo;
  @override
  void initState() { 
    super.initState();
    //se não for passado um RoutineModel existente
    //ou seja, se é um novo ou um ja existente
    _todo = widget.todo ?? TodoModel();
    _textController.text = _todo.title;
    //inicia variaveis
    _title = (_todo == null) ? _todo.title : '';
    _day = widget.day;
    _time = (_todo == null) ? _todo.time : '';
    _activitie = widget.activiti;
  }
  
  
  @override
  Widget build(BuildContext _context){  
    SizeConfig().init(context);

    return Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: (26*SizeConfig.blockSizeVertical)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 25,
          child: Center (
            child: Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _titleInput(),
                _timeView(),
                _buttons(),
              ],),
        )));
    }

  Widget _timeView()
  {
    return (_time == '') ? Container(child: Text('', style: theme.theme.textTheme.bodyText1,)):
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.bottomLeft,
            child: Text('Time: $_time', style: theme.theme.textTheme.button,)
          );
  }

  Widget _titleInput(){
    return Container( 
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelText: 'New Task'),
        maxLength: 30,
        style: theme.theme.textTheme.headline6,
        onChanged: (String value){
          _title = value;
        },
        )
      );
  }

  //verifica se e possivel salvar, ou se ha campos em branco
  //habilita ou desabilita botao salvar
  bool _isAble()
  {
    return _title == '';
  }

  _save() async {

    TodoModel task = TodoModel(day: widget.day, title: _title, time: _time, activitie: widget.activiti);
    final list = Provider.of<HomeController>(context, listen: false);
    if(widget.todo == null)
    {
      await list.add(task);
    }
    else
    {
      widget.todo.title = _title;
      widget.todo.time = _time;
      widget.todo.check = _check;

      await list.update(widget.todo);
    }
  }

  _back(){
    Navigator.pop(context);
  }
  
  Widget _buttons(){
    return Container(
      margin: EdgeInsets.only(top: 45),
      width: double.infinity,
      child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //Botoes para salvar e cancelar
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          FlatButton(child: Text('Save', style: theme.theme.textTheme.headline5,), 
            onPressed: _isAble() ? null : (){
                _save();
                _back();
              },
            ),
          FlatButton(child: Text('Cancel', style: theme.theme.textTheme.headline5), 
          onPressed: (){
            _back();
          },),
        ],),

        //Outras opções
        //horário
        IconButton(icon: Icon(Icons.access_time, color: theme.theme.buttonColor), 
              onPressed: ()async {
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
                  _time = timeConverter.toStr(newTime);
                  print(newTime);
                  print(_time);
                });
            },)
        
      ],),
    );
  }
}