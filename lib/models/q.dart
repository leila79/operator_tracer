import 'package:human_resources/models/question_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'q.g.dart';

@JsonSerializable()
class Q {
  Q(this.id, this.checklistID, this.pages);

  int id;
  int checklistID;
  List<QuestionItem> pages;

  factory Q.fromJson(Map<String, dynamic> json) => _$QFromJson(json);

  Map<String, dynamic> toJson() => _$QToJson(this);
}
