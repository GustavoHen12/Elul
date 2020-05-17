import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:Elul/models/routineModel.dart';

class RoutineService extends Disposable {
  Completer<Box> completer = Completer<Box>();

  RoutineService() {
    _initDB();
  }

  _initDB() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = await Hive.openBox("activities");

    if (!completer.isCompleted) completer.complete(box);
  }

  Future<List<RoutineModel>> getAll() async {
    final box = await completer.future;
    return box.values.map((item) => RoutineModel.fromJson(item)).toList();
  }

  Future<RoutineModel> add(RoutineModel model) async {
    final box = await completer.future;
    model.id = box.values.length;
    await box.put(box.values.length, model.toJson());
    return model;
  }

  update(RoutineModel model) async {
    final box = await completer.future;
    await box.put(model.id, model.toJson());
  }

  remove(int id) async {
    final box = await completer.future;
    await box.delete(id);
  }

  clear() async {
    final box = await completer.future;
    await box.clear();
  }

  @override
  void dispose() async {
    final box = await completer.future;
    box.close();
  }
}