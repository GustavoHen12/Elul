import 'package:Elul/icons/elul_icons_icons.dart';
import 'package:Elul/screens/routine_dashboard/routine_page.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/screens/widgets/home/activitiCard.dart';
import 'package:Elul/themes/theme_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  ThemeStore theme;
  DateTime _day;
  String _weekday;
  bool _todayOrTomorrow = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme ??= Provider.of<ThemeStore>(context);
  }

  @override
  void initState() { 
    super.initState();
    _day = DateTime.now();
    _weekday = DateFormat('EEEE').format(DateTime.now());
    _todayOrTomorrow = true;
  }
  Widget _void = Container();

  //recebe um dia e a lista de atividades
  //retorna uma lista com as ativades do dia
  List _getListOfActivities(List lista, String day)
  {
    List list = new List.from(lista);
    List listOfDay =  new List();
    list.forEach((element) {
        if(element.days.contains(day))
          listOfDay.add(element);
     });
    listOfDay.sort((a, b) => int.parse(((a.startTime.split(':'))[0])).compareTo(int.parse((b.startTime.split(':'))[0])));
    return listOfDay;
  }

  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<RoutineController>(context);
    DateTime selectedDate = DateTime.now();
    return Scaffold(
      backgroundColor: theme.theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
              onPressed: ()async{
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: _day ?? selectedDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101));
                if (picked != null && picked != selectedDate)
                {
                  int diference = picked.day - DateTime.now().day;
                  if(diference >= 0)
                    setState(() {
                      //print("_day");
                      _day = picked;
                      _weekday = DateFormat('EEEE').format(picked);
                      _todayOrTomorrow = diference < 2;
                      print(_todayOrTomorrow);
                    });
                }
              },
              child: Icon(ElulIcons.calendar_icon, color: theme.theme.iconTheme.color,),),
      body: new SafeArea(
        child: 
          CustomScrollView(
            slivers: <Widget>[
              //APP BAR com efeito
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                leading: _popUpMenu(),
                actions: <Widget>[_buildRoutinBottom()],
                title: _todayOrTomorrow ? _buildDay() : _void,
                titleSpacing: 20,
                backgroundColor: theme.theme.backgroundColor,
                expandedHeight: 100,
                centerTitle: true,
                elevation: 15,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: _buildDayDescription(),
                  title: _todayOrTomorrow ? _void: _buildDay(),
                ),
              ),
              Observer(
              builder: (_)=>
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                        List listOfActivities = _getListOfActivities(activities.list, _weekday);
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ActivitiCard(activiti: listOfActivities[index], day: _day));
                    },
                    childCount: _getListOfActivities(activities.list, _weekday).length)
                )
              )                
            ],
          )
    ));
  }
  
  

  Widget _popUpMenu()
  {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 10,
      offset: Offset(0, 50),
      icon: Icon(Icons.more_vert),
      onSelected: (value){
        if(value == 1)
        {
          theme.toggleTheme();
        }
      },
      itemBuilder: (context)=>[
        PopupMenuItem(
          child: Text(theme.isDark ? 'Light Mode':'Dark Mode'),
          value: 1,),
        PopupMenuItem(
          child: Text('Portuguese'),//PARA FAZER
          value: 2,),
      ]);
  }
  

  Widget _buildDay()
  {
    String _date = DateFormat('E, d MMM').format(_day);

    return new Container(
      child:
          Text(_date, style: theme.theme.textTheme.headline5) 
     );
  }

  
  Widget _buildDayDescription()
  {
    int diference = _day.day - DateTime.now().day;
    if(diference <= 1)
    {
      return new SizedBox(
        height: double.infinity,
        width: double.infinity,
        child:Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 10),
        child:
          Text((diference != 1) ? 'Today':'Tomorrow', 
                style: theme.theme.textTheme.headline2)
      ));
    }
    else
    {
      return Container();
    }
  }

  Widget _buildRoutinBottom()
  {
    return Container(
      margin:EdgeInsets.only(right: 10), 
      child:
        IconButton(
          icon: Icon(
            ElulIcons.routine_icon, 
            color: theme.theme.buttonColor,
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