// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$listAtom = Atom(name: '_HomeBase.list');

  @override
  ObservableList<TaskModel> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<TaskModel> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$addAsyncAction = AsyncAction('_HomeBase.add');

  @override
  Future add(TaskModel model) {
    return _$addAsyncAction.run(() => super.add(model));
  }

  final _$removeAsyncAction = AsyncAction('_HomeBase.remove');

  @override
  Future remove(int id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  final _$updateAsyncAction = AsyncAction('_HomeBase.update');

  @override
  Future update(TaskModel model) {
    return _$updateAsyncAction.run(() => super.update(model));
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
