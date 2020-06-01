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
  Widget _widgetActive;
  @override
  Widget build(BuildContext context) {
    theme ??= Provider.of<ThemeStore>(context);
    _widgetActive = widget.value
                ? Icon(
                    Icons.check,
                    size: 30.0,
                    color: theme.theme.accentColor,
                    key: ValueKey(1),
                  )
                : Icon(
                    Icons.radio_button_unchecked ,
                    size: 30.0,
                    color: theme.theme.accentColor,
                    key: ValueKey(2),
                  );
    return Center(
      child: InkWell(
      onTap: widget.onChange,
      onLongPress: widget.onLongPress,
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 5), 
        child: Row(
        children: <Widget>[
          Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(color: Colors.transparent),
          child:
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: _widgetActive,
          )
          ),
          Flexible(child: widget.title,)
        
      ],)
      )
    ));
  }
}