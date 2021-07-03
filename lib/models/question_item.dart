import 'package:json_annotation/json_annotation.dart';

part 'question_item.g.dart';

@JsonSerializable()
class QuestionItem {
  QuestionItem(this.name, this.elements);

  String name;
  List<Map<String, dynamic>> elements;

  factory QuestionItem.fromJson(Map<String, dynamic> json) =>
      _$QuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionItemToJson(this);
}
