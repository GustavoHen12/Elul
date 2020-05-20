import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'routineModel.g.dart';

class RoutineModel extends _RoutineModel with _$RoutineModel {
  RoutineModel({int id, String title, List days, TimeOfDay startTime, TimeOfDay endTime})
      : super(id: id, title: title, days: days, startTime: startTime, endTime: endTime);

  toJson() {
    return {"id": id, "title": title, "days": days, "startTime": startTime, "endTime": endTime};
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

  @observable TimeOfDay startTime;

  @observable TimeOfDay endTime;

  _RoutineModel({this.id, this.title, this.days, this.startTime, this.endTime});
}