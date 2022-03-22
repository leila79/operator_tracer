import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:human_resources/database/models/answers_db.dart';
import 'package:human_resources/database/models/question_db.dart';
import 'package:human_resources/database/models/question_item_db.dart';
import 'package:human_resources/models/q.dart';
import 'package:human_resources/models/question_item.dart';
import 'package:human_resources/network/local.dart';
import 'package:path_provider/path_provider.dart';

class QuestionRepository {
  List<QuestionItem> items = [];
  Map<String, dynamic> answers = {};
  int pageNum = 1;
  int numberOfPages = 0;
  late int checklistID;

  Future<List<QuestionItem>> getItemData(int pageNum) async {
    // answers = {};
    final path = await _localPath;
    final fileExist = await File("$path/tempAnswers$pageNum.json").exists();
    if (fileExist) {
      // print('file$pageNum did exist');
      final file = File("$path/tempAnswers$pageNum.json");
      String a = await file.readAsString();
      // print('a : $a');
      if (a != "") {
        // print("file had data");
        answers = jsonDecode(a);
      }
      // print("answers : $answers");
    }
    var res = await LocalApiHelper().parseJson("questions");
    // print(res);
    List temp = res['pages'] as List;
    List<QuestionItem> tempQuestions =
        temp.map((e) => QuestionItem.fromJson(e)).toList();
    items = [];
    numberOfPages = tempQuestions.length;
    for (QuestionItem q in tempQuestions) {
      if (q.name == "page$pageNum") {
        items.add(q);
      }
    }
    return items;
  }

  Future<List<QuestionItem>> getItemDataQ(int pageNum, int checklistNum) async {
    // answers = {};
    final path = await _localPath;
    this.checklistID = checklistNum;
    try {
      final fileExist =
          await File("$path/tempAnswers$checklistID$pageNum.json").exists();
      if (fileExist) {
        // print('file$pageNum did exist');
        final file = File("$path/tempAnswers$checklistID$pageNum.json");
        String a = await file.readAsString();
        // print('a : $a');
        if (a != "") {
          // print("file had data");
          answers = jsonDecode(a);
        }
        // print("answers : $answers");
      }
    } catch (e) {
      print(e);
    }

    var res = await LocalApiHelper().parseJson("q");
    final Box<QuestionDB> questionBox = Hive.box('questions');
    List data = res['data'] as List;
    List<Q> q = data.map((e) => Q.fromJson(e)).toList();
    items = [];
    for (Q d in q) {
      if (d.checklistID == checklistNum) {
        List<QuestionItem> tempQuestions = d.pages;
        numberOfPages = tempQuestions.length;
        for (QuestionItem q in tempQuestions) {
          if (q.name == "page$pageNum") {
            print(q.name);
            items.add(q);
          }
        }
      }
    }
    List<QuestionItemDB> tempItems = [];
    bool inHive = false;
    for (Q questions in q) {
      inHive = false;
      if (questionBox.isEmpty) {
        tempItems = [];
        for (QuestionItem questionItem in questions.pages) {
          tempItems.add(
            QuestionItemDB(questionItem.name, questionItem.elements),
          );
        }
        QuestionDB item =
            QuestionDB(questions.id, questions.checklistID, tempItems);
        questionBox.add(item);
      } else {
        for (QuestionDB i in questionBox.values) {
          if (questions.id == i.id) {
            inHive = true;
            break;
          }
        }
        if (inHive == false) {
          tempItems = [];
          for (QuestionItem questionItem in questions.pages) {
            tempItems.add(
              QuestionItemDB(questionItem.name, questionItem.elements),
            );
          }
          QuestionDB item =
              QuestionDB(questions.id, questions.checklistID, tempItems);
          questionBox.add(item);
        }
      }
    }
    // List temp = res['pages'] as List;
    // List<QuestionItem> tempQuestions =
    //     temp.map((e) => QuestionItem.fromJson(e)).toList();
    return items;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> addItemData(Map<String, dynamic> answer) async {
    final Box<AnswersDB> answerBox = Hive.box('answers');
    print(this.checklistID);
    AnswersDB answers = AnswersDB(this.checklistID, answer);
    answerBox.add(answers);
    answer['checklistID'] = this.checklistID;
    final path = await _localPath;
    final file = File("$path/answers.json");
    file.writeAsStringSync(json.encode(answer));
    print(file.readAsStringSync());
  }

  Future<void> addTempData(Map<String, dynamic> answers, int pageNum) async {
    final path = await _localPath;
    final file = File("$path/tempAnswers$checklistID$pageNum.json");
    await file.writeAsString(json.encode(answers));
    // print("temp file saved : ${file.readAsStringSync()}");
  }

  Future<int> deleteFiles(int pageNum) async {
    print("in delete");
    try {
      final path = await _localPath;
      // while (pageNum != 0) {
      //   final file = File("$path/tempAnswers$pageNum.json");
      //   await file.writeAsString("");
      //   pageNum--;
      // }
      pageNum = 1;
      while (true) {
        final fileExist =
            await File("$path/tempAnswers$checklistID$pageNum.json").exists();
        if (fileExist) {
          print('file tempAnswers$checklistID$pageNum did exist');
          final file = File("$path/tempAnswers$checklistID$pageNum.json");
          await file.writeAsString("");
          pageNum++;
        } else {
          break;
        }
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}
