import 'package:Elul/screens/routine_dashboard/routine_services.dart';
import 'package:Elul/models/routineModel.dart';
import 'package:mobx/mobx.dart';

part 'routine_store.g.dart';

class RoutineController = _RoutineBase with _$RoutineController;

abstract class _RoutineBase with Store {
  final service = new RoutineService();

  _RoutineBase() {
    _init();
  }

  _init() async {
    final allList = await service.getAll();
    list.addAll(allList);
  }

  @action
  add(RoutineModel model) async {
    model = await service.add(model);
    list.add(model);
  }

  @action
  remove(int id) async {
    await service.remove(id);
    list.removeWhere((item) => item.id == id);
  }

  @action
  update(RoutineModel model) async {
    await service.update(model);
  }

  @action
  cleanAll() async {
    await service.clear();
    list.clear();
  }

  @observable
  ObservableList<RoutineModel> list = ObservableList<RoutineModel>();

  @computed
  int get itemsTotal => list.length;

  @computed
  //int get itemsTotalCheck => list.where((item) => item.id).length;
  int get itemsTotalCheck => list.length;
}