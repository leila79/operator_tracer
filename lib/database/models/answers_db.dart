import 'package:hive/hive.dart';

part 'answers_db.g.dart';

@HiveType(typeId: 6)
class AnswersDB {
  AnswersDB(this.checklistID, this.answer);

  @HiveField(1)
  int checklistID;
  @HiveField(2)
  Map<String, dynamic> answer;
}
