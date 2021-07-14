import 'package:json_annotation/json_annotation.dart';

part 'user_auth.g.dart';

@JsonSerializable()
class UserAuth {
  UserAuth(this.userid, this.t, this.name, this.pic);

  int userid;
  int t;
  String name;
  String pic;

  factory UserAuth.fromJson(Map<String, dynamic> json) =>
      _$UserAuthFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthToJson(this);
}
