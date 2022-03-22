// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswersDBAdapter extends TypeAdapter<AnswersDB> {
  @override
  final int typeId = 6;

  @override
  AnswersDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswersDB(
      fields[1] as int,
      (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnswersDB obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.checklistID)
      ..writeByte(2)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswersDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
