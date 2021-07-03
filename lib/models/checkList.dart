import 'package:human_resources/models/check_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkList.g.dart';

@JsonSerializable()
class CheckList {
  CheckList(this.id, this.storeId, this.items);

  int id;
  int storeId;
  List<CheckItem> items;

  factory CheckList.fromJson(Map<String, dynamic> json) =>
      _$CheckListFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListToJson(this);
}
