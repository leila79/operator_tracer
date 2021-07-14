// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['status'] as int,
    json['id'] as int,
    json['email'] as String,
    json['name'] as String,
    json['img'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'img': instance.img,
    };
