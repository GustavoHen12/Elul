import 'package:hive/hive.dart';
part 'timeModel.g.dart';

@HiveType(typeId: 12)
class Time
{
  @HiveField(0)
  int minute = 0;
  @HiveField(1)
  int hour = 0;

  Time({this.minute, this.hour});
}
