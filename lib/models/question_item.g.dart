// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionItem _$QuestionItemFromJson(Map<String, dynamic> json) {
  return QuestionItem(
    json['name'] as String,
    (json['elements'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$QuestionItemToJson(QuestionItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'elements': instance.elements,
    };
