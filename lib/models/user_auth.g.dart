// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuth _$UserAuthFromJson(Map<String, dynamic> json) {
  return UserAuth(
    json['userid'] as int,
    json['t'] as int,
    json['name'] as String,
    json['pic'] as String,
  );
}

Map<String, dynamic> _$UserAuthToJson(UserAuth instance) => <String, dynamic>{
      'userid': instance.userid,
      't': instance.t,
      'name': instance.name,
      'pic': instance.pic,
    };
