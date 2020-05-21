// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeAdapter extends TypeAdapter<Time> {
  @override
  final typeId = 12;

  @override
  Time read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Time(
      minute: fields[0] as int,
      hour: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Time obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.minute)
      ..writeByte(1)
      ..write(obj.hour);
  }
}
