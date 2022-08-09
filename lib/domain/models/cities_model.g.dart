// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CitiesModelAdapter extends TypeAdapter<CitiesModel> {
  @override
  final int typeId = 1;

  @override
  CitiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CitiesModel()
      .._cityName = fields[0] as String?
      .._linkName = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, CitiesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._cityName)
      ..writeByte(1)
      ..write(obj._linkName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CitiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
