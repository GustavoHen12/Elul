import 'package:Elul/icons/elul_icons_icons.dart';
import 'package:Elul/screens/routine_dashboard/routine_page.dart';
import 'package:Elul/themes/theme_store.dart';
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
                actions: <Widget>[Container(margin:EdgeInsets.only(right: 10), child:
                          IconButton(icon: Icon(ElulIcons.routine_icon, 
                                                  color: theme.theme.accentColor,
                                                  size: 22,), 
                                            onPressed: (){
                                              Navigator.push(context, 
                                                            MaterialPageRoute(builder: (context) => RoutinePage())
                                              );
                                            }))],
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
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                                            Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text('Elemento'),
                      ),
                      
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
    
    return new Expanded(
      child:Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 10),
      child:
        Text(_day, style: theme.theme.textTheme.headline2)
    ));
  }

  // Widget _buildGrid()
  // {
  //   return Container(child: Text('test'),);
  // }
}
