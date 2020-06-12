/*
  -Time_Str: POR QUE EU EXISTO ?
  A solução mais elegante, para garantir que não fosse necessário criar esse "conversor",
seria salvando o horario como TimeOfDay, ou algum objeto que possua os atributos necessário para
representar esse dado.  
  O primeiro que eu encontre, foi com relação à gerar um adaptador para o Hive, porque ele não reconhecia 
o tipo do objeto que eu criei para representar o horário. Basicamente, o problema com o typeAdapter é que
ele diz que o tipo já existe (HiveError (HiveError: There is already a TypeAdapter for typeId 12.)).
Eu procurei soluções na internet, mas a única solução que eu encontrei foi essa: 
https://github.com/hivedb/hive/issues/85, mas nenhuma delas funcionou. 
  Mas eu descobri depois que o tipo TypeAdapter para o TimeOfDay esta presente no package Hive_flutter. 
Eu tentei implemetar com isso. Mas deu problema na serialização do objeto, mais especificamente para fazer 
o map de Json para o Objeto. O problema que dava era que ele não conseguia converter de String para 
TimeOfDay.
  Tentei contornar esses problemas na parte de serialização, ou seja, mandar um objeto mais complexo para
o Hive, mas apenas com os tipos elementares (int, String, ...). Portanto, eu teria que criar meu proprio
objeto para isso. Entretanto, o problema do map do fromJson persistia. Eu tentei utilizar o json_serializable
e o dart_json_mapper. Mas com o json_serializable, ele basicamente não "reconhecia" o package então ele 
não conseguia montar. E com o dart_json_mapper, ele não fazia nada. O maior problema com esses dois,
é que eles tem que trabalhar junto com o mobx, e isso não vai muito bem.
  Eu tentei algumas outras abordagens, mas sem muito exito. 
Map<dynamic, dynamic>(volta do Hive) != Map<String, dynamic> 
  Eu creio, que a abordagem que é mais proxima de funcionar é essa ultima mesmo. É possivel ver 
mais sobre ela aqui https://github.com/mobxjs/mobx.dart/issues/147, e também no tutoria do proprio Hive
de uma Todo_list.
*/

// I/flutter ( 4911): TimeOfDay(15:29), 15 : 29 , DayPeriod.pm
// I/flutter ( 4911): TimeOfDay(00:29), 0 : 29 , DayPeriod.am
// I/flutter ( 4911): TimeOfDay(12:30), 12 : 30 , DayPeriod.pm

import 'package:flutter/material.dart';

class Time_Str
{
  
  toStr(TimeOfDay time){
    return '${time.hour.toString()}:${time.minute.toString()}';
  }

  toTime(String time){
    var listTime = time.split(':');
    int hours = int.parse(listTime[0]);
    int minutes = int.parse(listTime[1]);

    return new TimeOfDay(hour: hours, minute: minutes);
  }
}