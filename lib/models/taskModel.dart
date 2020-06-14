//import 'package:Elul/models/timeStr.dart';
import 'package:mobx/mobx.dart';

part 'taskModel.g.dart';


class TaskModel extends _TaskModel with _$TaskModel {
  TaskModel({int id, String title, String day, String time, String activitie, bool check})
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

  factory TaskModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return TaskModel(
        id: parsedJson['id'], 
        title: parsedJson['title'], 
        day: parsedJson['day'], 
        time: parsedJson['time'], 
        activitie: parsedJson['activitie'],
        check: parsedJson['check']);
  }
}

abstract class _TaskModel with Store {
  int id;

  @observable String title;

  @observable String day;

  @observable String time;

  @observable String activitie;

  @observable bool check;

  _TaskModel({this.id, this.title, this.day, this.time, this.activitie, this.check});
}