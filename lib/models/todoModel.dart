//import 'package:Elul/models/timeStr.dart';
import 'package:mobx/mobx.dart';

part 'todoModel.g.dart';


class TodoModel extends _TodoModel with _$TodoModel {
  TodoModel({int id, String title, String day, String time, String activitie, bool check})
      : super(id: id, title: title, day: day, time: time, activitie: activitie, check: check);

  toJson() {
    return {
      "id": id, 
      "title": title, 
      "day": day,  
      "time": time, 
      "activitie": activitie,
      "check": check,
    }; 
  }

  factory TodoModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return TodoModel(
        id: parsedJson['id'], 
        title: parsedJson['title'], 
        day: parsedJson['day'], 
        time: parsedJson['time'], 
        activitie: parsedJson['activitie'],
        check: parsedJson['check']);
  }
}

abstract class _TodoModel with Store {
  int id;

  @observable String title;

  @observable String day;

  @observable String time;

  @observable String activitie;

  @observable bool check;

  _TodoModel({this.id, this.title, this.day, this.time, this.activitie, this.check});
}