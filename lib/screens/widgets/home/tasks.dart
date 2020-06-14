import 'package:Elul/models/taskModel.dart';
import 'package:Elul/screens/home/home_store.dart';
import 'package:Elul/screens/widgets/home/checkBox.dart';
import 'package:Elul/screens/widgets/home/dialogBoxTask.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class BuildTasks extends StatefulWidget {
  ObservableList<TaskModel> tasks;
  String activiti;
  DateTime day;
  BuildTasks({@required this.tasks, @required this.activiti, @required this.day});

  @override
  _BuildTasksState createState() => _BuildTasksState();
}

class _BuildTasksState extends State<BuildTasks> {
  
  ThemeStore theme;
  
  bool _removeMode = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<HomeController>(context);
    return Observer(
      builder: (_)=>
          Expanded( 
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: taskList.list.length,
            itemBuilder: (context, index){
              //se a atividade da tarefa corresponde a atividade do card
              if((taskList.list[index].activitie == widget.activiti) &&
                (taskList.list[index].day == DateFormat('EEE, d MMMM').format(widget.day)))
                return Observer( builder: (_)=>_BuildTasks(taskList.list[index]) );
              else 
                return Container();
            }),
        )
      );
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

  Widget _BuildTasks(TaskModel task)
  {
    final taskList = Provider.of<HomeController>(context);
    //se esta no modo remove exibe os botoes para remover e editar
    Widget _removeWidget = _removeMode ? Container(key: ValueKey(1)) :
      Row(
        key: ValueKey(2),
        children:[
          IconButton(icon: Icon(Icons.edit,
                      color: theme.isDark ? Colors.white54 : Colors.grey[400]),
          onPressed: (){
              dialogBox(activiti: widget.activiti, 
                      day: task.day,
                      todo: task);
          },),
          IconButton(icon: Icon(Icons.delete_outline, 
                  color: theme.isDark ? Colors.white54 : Colors.grey[400]), 
                  onPressed: ()async{
                                taskList.remove(task.id);
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Item Removed'),
                                    duration: Duration(seconds: 2),
                                  )
                                );
                              } 
                    ) 
        ]
      );
    if(task.check == null)
    {  
      task.check = false;
      taskList.update(task);
    }
    if(task.title == null)
      return Container();

    theme ??= Provider.of<ThemeStore>(context);
    
    return Container(
      height: 40,
      width: double.infinity,
      child:
      Row(
        children: <Widget>[
          Flexible(
            child: CheckTask( 
            title: Text(task.title, style: TextStyle(fontSize: 15,
                                                    fontFamily: "OpenSans", 
                                                    fontWeight: FontWeight.w600)),
            value: task.check, 
            onChange:(){
              setState(() {
                task.check = !task.check;
                taskList.update(task);            
              });
            },
            onLongPress: (){
              setState(() {
                _removeMode = !_removeMode;
              });
            }),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _removeWidget,
          )
        ],
      )
      ,
    );
  }
}