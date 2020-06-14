// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskModel on _TaskModel, Store {
  final _$titleAtom = Atom(name: '_TaskModel.title');

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

  final _$dayAtom = Atom(name: '_TaskModel.day');

  @override
  String get day {
    _$dayAtom.reportRead();
    return super.day;
  }

  @override
  set day(String value) {
    _$dayAtom.reportWrite(value, super.day, () {
      super.day = value;
    });
  }

  final _$timeAtom = Atom(name: '_TaskModel.time');

  @override
  String get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(String value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  final _$activitieAtom = Atom(name: '_TaskModel.activitie');

  @override
  String get activitie {
    _$activitieAtom.reportRead();
    return super.activitie;
  }

  @override
  set activitie(String value) {
    _$activitieAtom.reportWrite(value, super.activitie, () {
      super.activitie = value;
    });
  }

  final _$checkAtom = Atom(name: '_TaskModel.check');

  @override
  bool get check {
    _$checkAtom.reportRead();
    return super.check;
  }

  @override
  set check(bool value) {
    _$checkAtom.reportWrite(value, super.check, () {
      super.check = value;
    });
  }

  @override
  String toString() {
    return '''
title: ${title},
day: ${day},
time: ${time},
activitie: ${activitie},
check: ${check}
    ''';
  }
}
