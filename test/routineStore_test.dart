import 'package:Elul/screens/routine_dashboard/routine_services.dart';
import 'package:Elul/screens/routine_dashboard/routine_store.dart';
import 'package:Elul/models/routineModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('teste stores da rotina',(){
    // test('inicia', (){
    //   expect(actual, matcher);
    // });

    //LocalStorageService service = new LocalStorageService();
    final routine = RoutineController();
    //TESTA NO INICIO
//      _RoutineModel({this.id, this.title, this.days, this.startTime, this.endTime});
    // test('adiciona', (){
    //   var model = new RoutineModel(
    //     title: 'teste',
    //     days: ['monday', 'thursday', 'sunday'],
    //     startTime: 12.00,
    //     endTime: 01.00        
    //   );

    //   routine.add(model);
    //   expect(routine.list, model);
    // });

    // test('update', (){
    //   var model = new RoutineModel(
    //     id: 12,
    //     title: 'teste',
    //     days: ['monday', 'wednesday', 'sunday'],
    //     startTime: 12.00,
    //     endTime: 01.00        
    //   );

    //   routine.update(model);
    //   expect(routine.list, model);
    // });

    test('remove', (){
      routine.remove(12);
      expect(routine.list, null);
    });
  } 
  );
}
