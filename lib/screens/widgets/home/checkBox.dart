import 'package:Elul/themes/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckTask extends StatefulWidget {
  final Widget title;
  final bool value;
  final GestureTapCallback onChange;
  final GestureLongPressCallback onLongPress;
  CheckTask({@required this.title, @required this.value, @required this.onChange, this.onLongPress});

  @override
  _CheckTaskState createState() => _CheckTaskState();
}

class _CheckTaskState extends State<CheckTask> {
  ThemeStore theme;
  @override
  Widget build(BuildContext context) {
    theme ??= Provider.of<ThemeStore>(context);
    
    return Center(
      child: InkWell(
      onTap: widget.onChange,
      onLongPress: widget.onLongPress,
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 5), 
        child: Row(
        children: <Widget>[
        
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: 
          Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: widget.value
                ? Icon(
                    Icons.check,
                    size: 30.0,
                    color: theme.theme.accentColor,
                  )
                : Icon(
                    Icons.radio_button_unchecked ,
                    size: 28.0,
                    color: theme.theme.accentColor,
                  ),
          )),
          Flexible(child: widget.title,)
        
      ],)
      )
    ));
  }
}