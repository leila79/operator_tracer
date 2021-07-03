// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckItem _$CheckItemFromJson(Map<String, dynamic> json) {
  return CheckItem(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['date'] as String,
    json['time'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$CheckItemToJson(CheckItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'time': instance.time,
      'status': instance.status,
    };
