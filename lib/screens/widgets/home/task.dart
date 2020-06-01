import 'package:Elul/models/todoModel.dart';
import 'package:Elul/screens/home/home_store.dart';
import 'package:Elul/screens/widgets/home/checkBox.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
/**
 * Fazer:
 * 1) Update, onLongPress
 * 2) Remove Mode
 *    2.1)Animated list
 * 3)Calendario
 *    3.1)Ajustar datas
 * 4) Notificação
 * 5) Arrumar código
 */

class BuildTask extends StatefulWidget {
  //TodoModel task;
  ObservableList<TodoModel> tasks;
  String activiti;
  BuildTask({@required this.tasks, @required this.activiti});

  @override
  _BuildTaskState createState() => _BuildTaskState();
}

double _getHeigh (List tasks, String activiti)
{
  int count = 0;
  tasks.forEach((element) {
    if(element.activitie == activiti)
      count++;
  });

  return count*40.0;
}

class _BuildTaskState extends State<BuildTask> {
  
  ThemeStore theme;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<HomeController>(context);
    //ObservableList taskList = widget.tasks;
    return Observer(builder: (_)=>
    SizedBox(
      height: _getHeigh(taskList.list, widget.activiti),
      child: Container( 
       child: ListView.builder(
         itemCount: taskList.list.length,
         itemBuilder: (context, index){
           print(taskList.list[index]);
           if(taskList.list[index].activitie == widget.activiti)
            return _buildTask(taskList.list[index]);
          else 
            return Container();
         }),
      )
    ));
  }

  Widget _buildTask(TodoModel task)
  {
    final taskList = Provider.of<HomeController>(context);
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
      child:
      CheckTask( 
      //CheckboxListTile(
        //controlAffinity: ListTileControlAffinity.leading,
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
          taskList.remove(task.id);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Item Removed'),
              duration: Duration(seconds: 2),
            )
          );
        },),
    );
  }
}