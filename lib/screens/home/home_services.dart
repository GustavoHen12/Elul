import 'dart:async';
import 'package:Elul/models/taskModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;



class HomeService extends Disposable {
  Completer<Box> completer = Completer<Box>();

  HomeService() {
    _initDB();
  }

  _initDB() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    //Hive.registerAdapter(TimeOfDayAdapter());
    final box = await Hive.openBox("todo");
    

    if (!completer.isCompleted) completer.complete(box);
  }

  Future<List<TaskModel>> getAll() async {
    final box = await completer.future;
    return box.values.map((item) => TaskModel.fromJson(item)).toList();
  }

  Future<TaskModel> add(TaskModel model) async {
    final box = await completer.future;
    model.id = box.values.length;
    await box.put(box.values.length, model.toJson());
    return model;
  }

  update(TaskModel model) async {
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