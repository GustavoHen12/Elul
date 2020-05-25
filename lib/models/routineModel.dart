import 'package:Elul/models/timeStr.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';

part 'routineModel.g.dart';


class RoutineModel extends _RoutineModel with _$RoutineModel {
  RoutineModel({int id, String title, List days, String startTime, String endTime})
      : super(id: id, title: title, days: days, startTime: startTime, endTime: endTime);

  toJson() {
    return {
      "id": id, 
      "title": title, 
      "days": days,  
      "startTime": startTime, 
      "endTime": endTime,
    }; 
  }

  factory RoutineModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return RoutineModel(
        id: parsedJson['id'], 
        title: parsedJson['title'], 
        days: parsedJson['days'], 
        startTime: parsedJson['startTime'], 
        endTime: parsedJson['endTime']);
  }
}

abstract class _RoutineModel with Store {
  int id;

  @observable String title;

  @observable List days;

  @observable String startTime;

  @observable String endTime;

  _RoutineModel({this.id, this.title, this.days, this.startTime, this.endTime});
}