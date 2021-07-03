import 'dart:convert';
import 'dart:io';

import 'package:human_resources/models/question_item.dart';
import 'package:human_resources/network/local.dart';
import 'package:path_provider/path_provider.dart';

class QuestionRepository {
  List<QuestionItem> items = [];
  Map<String, dynamic> answers = {};
  int pageNum = 1;
  int numberOfPages = 0;

  Future<List<QuestionItem>> getItemData(int pageNum) async {
    // answers = {};
    final path = await _localPath;
    final fileExist = await File("$path/tempAnswers$pageNum.json").exists();
    if (fileExist) {
      print('file$pageNum did exist');
      final file = File("$path/tempAnswers$pageNum.json");
      String a = await file.readAsString();
      print(a);
      if (a != "") {
        print("file had data");
        answers = jsonDecode(a);
      }
      print("answers : $answers");
    }
    var res = await LocalApiHelper().parseJson("questions");
    print(res);
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> addItemData(Map<String, dynamic> answer) async {
    final path = await _localPath;
    final file = File("$path/answers.json");
    file.writeAsStringSync(json.encode(answer));
    print(file.readAsStringSync());
  }

  Future<void> addTempData(Map<String, dynamic> answers, int pageNum) async {
    final path = await _localPath;
    final file = File("$path/tempAnswers$pageNum.json");
    await file.writeAsString(json.encode(answers));
    print("temp file saved : ${file.readAsStringSync()}");
  }

  Future<int> deleteFiles(int pageNum) async {
    print("in delete");
    try {
      final path = await _localPath;
      while (pageNum != 0) {
        final file = File("$path/tempAnswers$pageNum.json");
        await file.writeAsString("");
        pageNum--;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }
}
