// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreDBAdapter extends TypeAdapter<StoreDB> {
  @override
  final int typeId = 2;

  @override
  StoreDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreDB(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoreDB obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
