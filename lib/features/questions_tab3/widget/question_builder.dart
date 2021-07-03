import 'package:flutter/material.dart';
import 'package:human_resources/features/questions_tab3/widget/check_mark_questions.dart';
import 'package:human_resources/features/questions_tab3/widget/radio_group_questions.dart';
import 'package:human_resources/features/questions_tab3/widget/text_questions.dart';
import 'file_picker_questions.dart';

class QuestionBuilder extends StatelessWidget {
  Map<String, dynamic> element;
  List<String> listAnswer = [];
  String answer = "";
  dynamic oldAns;
  late CheckMarkQ _checkMarkQ;
  late RadioGroupQ _radioGroupQ;
  late TextQ _textQ;
  late FileQ _fileQ;
  QuestionBuilder({required this.element, required this.oldAns});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      child: itemBuilder(),
    );
  }

  void value() {
    listAnswer = [];
    switch (element['type']) {
      case ('checkbox'):
        {
          listAnswer.addAll(_checkMarkQ.getValues());
          print(listAnswer);
          break;
        }
      case ('radiogroup'):
        {
          answer = _radioGroupQ.selected != null ? _radioGroupQ.selected! : "";
          break;
        }
      case ("text"):
        {
          answer = _textQ.answer;
          break;
        }
      case ("file"):
        {
          listAnswer.add(_fileQ.type);
          listAnswer.add(_fileQ.content);
          break;
        }
      default:
        {
          break;
        }
    }
  }

  Widget itemBuilder() {
    switch (element['type']) {
      case ('checkbox'):
        {
          List<String> ans = [];
          if (oldAns != null) {
            ans = List<String>.from(oldAns.where((i) => i is String));
          }
          _checkMarkQ = CheckMarkQ(
            name: element["name"],
            choices: element["choices"],
            answers: ans,
          );
          return _checkMarkQ;
        }
      case ('radiogroup'):
        {
          _radioGroupQ = RadioGroupQ(
            name: element["name"],
            choices: element["choices"],
            selected: oldAns,
          );
          return _radioGroupQ;
        }
      case ("text"):
        {
          _textQ = TextQ(
            name: element["name"],
            answer: oldAns != null ? oldAns : "",
          );
          return _textQ;
        }
      case ("file"):
        {
          _fileQ = FileQ(
            name: element["name"],
            maxSize: element["maxSize"],
          );
          return _fileQ;
        }
      default:
        {
          return Container();
        }
    }
  }
}
