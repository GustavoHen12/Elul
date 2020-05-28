// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  Computed<int> _$itemsTotalComputed;

  @override
  int get itemsTotal => (_$itemsTotalComputed ??=
          Computed<int>(() => super.itemsTotal, name: '_HomeBase.itemsTotal'))
      .value;
  Computed<int> _$itemsTotalCheckComputed;

  @override
  int get itemsTotalCheck =>
      (_$itemsTotalCheckComputed ??= Computed<int>(() => super.itemsTotalCheck,
              name: '_HomeBase.itemsTotalCheck'))
          .value;

  final _$listAtom = Atom(name: '_HomeBase.list');

  @override
  ObservableList<TodoModel> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<TodoModel> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$addAsyncAction = AsyncAction('_HomeBase.add');

  @override
  Future add(TodoModel model) {
    return _$addAsyncAction.run(() => super.add(model));
  }

  final _$removeAsyncAction = AsyncAction('_HomeBase.remove');

  @override
  Future remove(int id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  final _$updateAsyncAction = AsyncAction('_HomeBase.update');

  @override
  Future update(TodoModel model) {
    return _$updateAsyncAction.run(() => super.update(model));
  }

  final _$cleanAllAsyncAction = AsyncAction('_HomeBase.cleanAll');

  @override
  Future cleanAll() {
    return _$cleanAllAsyncAction.run(() => super.cleanAll());
  }

  @override
  String toString() {
    return '''
list: ${list},
itemsTotal: ${itemsTotal},
itemsTotalCheck: ${itemsTotalCheck}
    ''';
  }
}
