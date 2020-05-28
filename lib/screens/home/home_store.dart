import 'package:Elul/models/todoModel.dart';
import 'package:Elul/screens/home/home_services.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final service = new HomeService();

  _HomeBase() {
    _init();
  }

  _init() async {
    final allList = await service.getAll();
    list.addAll(allList);
  }

  @action
  add(TodoModel model) async {
    model = await service.add(model);
    list.add(model);
  }

  @action
  remove(int id) async {
    await service.remove(id);
    list.removeWhere((item) => item.id == id);
  }

  @action
  update(TodoModel model) async {
    await service.update(model);
  }

  @action
  cleanAll() async {
    await service.clear();
    list.clear();
  }

  @observable
  ObservableList<TodoModel> list = ObservableList<TodoModel>();

  @computed
  int get itemsTotal => list.length;

  @computed
  //int get itemsTotalCheck => list.where((item) => item.id).length;
  int get itemsTotalCheck => list.length;
}