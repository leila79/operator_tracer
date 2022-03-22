// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionDBAdapter extends TypeAdapter<QuestionDB> {
  @override
  final int typeId = 5;

  @override
  QuestionDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionDB(
      fields[0] as int,
      fields[1] as int,
      (fields[2] as List).cast<QuestionItemDB>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.checklistID)
      ..writeByte(2)
      ..write(obj.pages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
