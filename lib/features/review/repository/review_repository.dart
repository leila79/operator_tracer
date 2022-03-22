import 'package:hive/hive.dart';
import 'package:human_resources/database/models/answers_db.dart';
import 'package:human_resources/database/models/checkList_db.dart';
import 'package:human_resources/database/models/items_db.dart';
import 'package:human_resources/database/models/question_db.dart';
import 'package:human_resources/database/models/store_db.dart';
import 'package:human_resources/models/check_item.dart';

class ReviewRepository {
  late StoreDB store;
  late QuestionDB question;
  late AnswersDB answers;

  Future<void> getChecklistData(CheckItem checkItem) async {
    final Box<StoreDB> storeBox = Hive.box('stores');
    final Box<QuestionDB> questionBox = Hive.box('questions');
    final Box<AnswersDB> answerBox = Hive.box('answers');
    final Box<CheckListDB> checklistBox = Hive.box('checklists');
    CheckListDB? checklist;
    bool found = false;
    for (CheckListDB checkList in checklistBox.values) {
      for (ItemDB item in checkList.items) {
        if (item.id == checkItem.id) {
          checklist = checkList;
          found = true;
          // print(checklist.id);
          // break;
        }
        if (found) break;
      }
    }

    for (StoreDB s in storeBox.values) {
      if (s.id == checklist!.storeId) {
        print(s.id);
        store = s;
        break;
      }
    }

    for (QuestionDB q in questionBox.values) {
      if (q.checklistID == checkItem.id) {
        question = q;
        print(question.id);
        break;
      }
    }

    for (AnswersDB a in answerBox.values) {
      if (a.checklistID == checkItem.id) {
        answers = a;
        print(answers.answer.toString());
        break;
      }
    }
  }
}
