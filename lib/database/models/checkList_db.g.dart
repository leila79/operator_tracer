// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkList_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListDBAdapter extends TypeAdapter<CheckListDB> {
  @override
  final int typeId = 3;

  @override
  CheckListDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckListDB(
      fields[0] as int,
      fields[1] as int,
      (fields[2] as List).cast<ItemDB>(),
    );
  }

  @override
  void write(BinaryWriter writer, CheckListDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storeId)
      ..writeByte(2)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
