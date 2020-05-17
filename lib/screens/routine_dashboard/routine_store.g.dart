// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoutineController on _RoutineBase, Store {
  Computed<int> _$itemsTotalComputed;

  @override
  int get itemsTotal =>
      (_$itemsTotalComputed ??= Computed<int>(() => super.itemsTotal,
              name: '_RoutineBase.itemsTotal'))
          .value;
  Computed<int> _$itemsTotalCheckComputed;

  @override
  int get itemsTotalCheck =>
      (_$itemsTotalCheckComputed ??= Computed<int>(() => super.itemsTotalCheck,
              name: '_RoutineBase.itemsTotalCheck'))
          .value;

  final _$listAtom = Atom(name: '_RoutineBase.list');

  @override
  ObservableList<RoutineModel> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<RoutineModel> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$addAsyncAction = AsyncAction('_RoutineBase.add');

  @override
  Future add(RoutineModel model) {
    return _$addAsyncAction.run(() => super.add(model));
  }

  final _$removeAsyncAction = AsyncAction('_RoutineBase.remove');

  @override
  Future remove(int id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  final _$updateAsyncAction = AsyncAction('_RoutineBase.update');

  @override
  Future update(RoutineModel model) {
    return _$updateAsyncAction.run(() => super.update(model));
  }

  final _$cleanAllAsyncAction = AsyncAction('_RoutineBase.cleanAll');

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
