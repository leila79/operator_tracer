import 'package:json_annotation/json_annotation.dart';

part 'check_item.g.dart';

@JsonSerializable()
class CheckItem {
  CheckItem(
      this.id, this.title, this.description, this.date, this.time, this.status);

  int id;
  String title;
  String description;
  String date;
  String time;
  String status;

  factory CheckItem.fromJson(Map<String, dynamic> json) =>
      _$CheckItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckItemToJson(this);
}
