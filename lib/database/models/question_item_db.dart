import 'package:hive/hive.dart';

part 'question_item_db.g.dart';

@HiveType(typeId: 4)
class QuestionItemDB {
  QuestionItemDB(this.name, this.elements);

  @HiveField(0)
  String name;
  @HiveField(1)
  List<Map<String, dynamic>> elements;
}
