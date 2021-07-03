// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckList _$CheckListFromJson(Map<String, dynamic> json) {
  return CheckList(
    json['id'] as int,
    json['storeId'] as int,
    (json['items'] as List<dynamic>)
        .map((e) => CheckItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CheckListToJson(CheckList instance) => <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'items': instance.items,
    };
