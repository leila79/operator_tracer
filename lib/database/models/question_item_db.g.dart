// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_item_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionItemDBAdapter extends TypeAdapter<QuestionItemDB> {
  @override
  final int typeId = 4;

  @override
  QuestionItemDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionItemDB(
      fields[0] as String,
      (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionItemDB obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.elements);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionItemDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
