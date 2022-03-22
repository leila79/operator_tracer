// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'q.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Q _$QFromJson(Map<String, dynamic> json) {
  return Q(
    json['id'] as int,
    json['checklistID'] as int,
    (json['pages'] as List<dynamic>)
        .map((e) => QuestionItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QToJson(Q instance) => <String, dynamic>{
      'id': instance.id,
      'checklistID': instance.checklistID,
      'pages': instance.pages,
    };
