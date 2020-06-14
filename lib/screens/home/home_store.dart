import 'package:Elul/models/taskModel.dart';
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
  add(TaskModel model) async {
    model = await service.add(model);
    list.add(model);
  }

  @action
  remove(int id) async {
    await service.remove(id);
    list.removeWhere((item) => item.id == id);
  }

  @action
  update(TaskModel model) async {
    await service.update(model);
  }

  @observable
  ObservableList<TaskModel> list = ObservableList<TaskModel>();
}