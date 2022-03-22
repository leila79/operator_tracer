import 'package:hive/hive.dart';
import 'package:human_resources/database/models/question_item_db.dart';

part 'question_db.g.dart';

@HiveType(typeId: 5)
class QuestionDB {
  QuestionDB(this.id, this.checklistID, this.pages);

  @HiveField(0)
  int id;
  @HiveField(1)
  int checklistID;
  @HiveField(2)
  List<QuestionItemDB> pages;
}
