import 'package:Elul/models/timeModel.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'routineModel.g.dart';


class RoutineModel extends _RoutineModel with _$RoutineModel {
  RoutineModel({int id, String title, List days, Time startTime, Time endTime})
      : super(id: id, title: title, days: days, startTime: startTime, endTime: endTime);

  toJson() {
    return {
      "id": id, 
      "title": title, 
      "days": days,  
      "startTime": {'hours': startTime.hour, 'minutes': startTime.minute }, 
      "endTime": {'hours': endTime.hour, 'minutes': endTime.minute }
    };
  }

  factory RoutineModel.fromJson(Map json) {
    return RoutineModel(
        id: json['id'], title: json['title'], days: json['days'], startTime: json['startTime'], endTime: json['endTime'] );
  }
}

abstract class _RoutineModel with Store {
  int id;

  @observable String title;

  @observable List days;

  @observable Time startTime;

  @observable Time endTime;

  _RoutineModel({this.id, this.title, this.days, this.startTime, this.endTime});
}