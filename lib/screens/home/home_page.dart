import 'package:Elul/icons/elul_icons_icons.dart';
import 'package:Elul/screens/routine_dashboard/routine_page.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//theme.toggleTheme
class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ThemeStore theme;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 244, 237),
      body: new SafeArea(
        child: 
          CustomScrollView(
            slivers: <Widget>[
              //APP BAR 
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                leading: IconButton(icon: Icon(Icons.more_vert), onPressed: (){}),
                actions: <Widget>[_buildRoutinBottom()],
                title: _buildDay(),
                titleSpacing: 20,
                backgroundColor: Color.fromARGB(255, 238, 244, 237),
                expandedHeight: 100,
                centerTitle: true,
                elevation: 15,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: _buildDayDescription(),
                ),

              ),
              SliverFixedExtentList(
                itemExtent: 100,
                delegate:SliverChildListDelegate([ 
                  BuildTodos(day: "Thursday"), 
                  //Container(child: Text("nada"),),                 
                ])
              )
               
            ],
          )
    ));
  }

  Widget _buildDay()
  {
    var date = DateTime.now();
    String _date = DateFormat('E, d MMM').format(date);

    return new Container(
      child:
          Text(_date, style: theme.theme.textTheme.headline5) 
     );
  }

  Widget _buildDayDescription()
  {
    String _day = 'Today';
    
    return new SizedBox(
      height: double.infinity,
      width: double.infinity,
      child:Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 10),
      child:
        Text(_day, style: theme.theme.textTheme.headline2)
    ));
  }

  Widget _buildRoutinBottom()
  {
    return Container(
      margin:EdgeInsets.only(right: 10), 
      child:
        IconButton(
          icon: Icon(
            ElulIcons.routine_icon, 
            color: theme.theme.accentColor,
            size: 22,), 
          onPressed: (){
            Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => RoutinePage())
            );
          }
        )
      );
  }
}

class BuildTodos extends StatefulWidget {
  final String day;
  BuildTodos({@required this.day});

  @override
  _BuildTodos createState() => _BuildTodos();
}

class _BuildTodos extends State<BuildTodos> {
  ThemeStore theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) { 
    final activities = Provider.of<RoutineController>(context);
    _getListOfActivities(activities.list);
    return Container(child: Text("nada"),);
  }

  // @override
  // void initState() { 
  //   super.initState();
    
  // }

  List _getListOfActivities(List lista)
  {
    List list = new List.from(lista);
    List listOfDay =  new List();
    print('# ${list.length}');
    list.forEach((element) {
        if(element.days.contains(widget.day))
          listOfDay.add(element);
     });
    listOfDay.sort((a, b) => int.parse(a.startTime.substring(0, 2)).compareTo(int.parse(b.startTime.substring(0, 2))));
    print('> -----${listOfDay}');
    return listOfDay;
  }
}