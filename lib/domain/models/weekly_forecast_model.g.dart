// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_forecast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyForecastModelAdapter extends TypeAdapter<WeeklyForecastModel> {
  @override
  final int typeId = 3;

  @override
  WeeklyForecastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyForecastModel()
      .._weekDay = fields[0] as String?
      .._date = fields[1] as String?
      .._condition = fields[2] as String?
      .._temp = fields[3] as String?
      .._rainProb = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, WeeklyForecastModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._weekDay)
      ..writeByte(1)
      ..write(obj._date)
      ..writeByte(2)
      ..write(obj._condition)
      ..writeByte(3)
      ..write(obj._temp)
      ..writeByte(4)
      ..write(obj._rainProb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyForecastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
