// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routineModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoutineModel on _RoutineModel, Store {
  final _$titleAtom = Atom(name: '_RoutineModel.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$daysAtom = Atom(name: '_RoutineModel.days');

  @override
  List<dynamic> get days {
    _$daysAtom.reportRead();
    return super.days;
  }

  @override
  set days(List<dynamic> value) {
    _$daysAtom.reportWrite(value, super.days, () {
      super.days = value;
    });
  }

  final _$startTimeAtom = Atom(name: '_RoutineModel.startTime');

  @override
  double get startTime {
    _$startTimeAtom.reportRead();
    return super.startTime;
  }

  @override
  set startTime(double value) {
    _$startTimeAtom.reportWrite(value, super.startTime, () {
      super.startTime = value;
    });
  }

  final _$endTimeAtom = Atom(name: '_RoutineModel.endTime');

  @override
  double get endTime {
    _$endTimeAtom.reportRead();
    return super.endTime;
  }

  @override
  set endTime(double value) {
    _$endTimeAtom.reportWrite(value, super.endTime, () {
      super.endTime = value;
    });
  }

  @override
  String toString() {
    return '''
title: ${title},
days: ${days},
startTime: ${startTime},
endTime: ${endTime}
    ''';
  }
}
