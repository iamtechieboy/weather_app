// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_day_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentDayModelAdapter extends TypeAdapter<CurrentDayModel> {
  @override
  final int typeId = 2;

  @override
  CurrentDayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentDayModel()
      .._loadDate = fields[0] as String?
      .._date = fields[1] as String?
      .._cityName = fields[2] as String?
      .._situation = fields[3] as String?
      .._humidity = fields[4] as String?
      .._wind = fields[5] as String?
      .._pressure = fields[6] as String?
      .._moon = fields[7] as String?
      .._sunset = fields[8] as String?
      .._sunrise = fields[9] as String?
      .._temp = fields[10] as String?
      .._tempN = fields[11] as String?;
  }

  @override
  void write(BinaryWriter writer, CurrentDayModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj._loadDate)
      ..writeByte(1)
      ..write(obj._date)
      ..writeByte(2)
      ..write(obj._cityName)
      ..writeByte(3)
      ..write(obj._situation)
      ..writeByte(4)
      ..write(obj._humidity)
      ..writeByte(5)
      ..write(obj._wind)
      ..writeByte(6)
      ..write(obj._pressure)
      ..writeByte(7)
      ..write(obj._moon)
      ..writeByte(8)
      ..write(obj._sunset)
      ..writeByte(9)
      ..write(obj._sunrise)
      ..writeByte(10)
      ..write(obj._temp)
      ..writeByte(11)
      ..write(obj._tempN);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentDayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
