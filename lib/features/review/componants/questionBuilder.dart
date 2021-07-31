import 'package:flutter/material.dart';
import 'package:human_resources/features/review/componants/check_mark_questions.dart';
import 'package:human_resources/features/review/componants/file_picker_questions.dart';
import 'package:human_resources/features/review/componants/radio_group_questions.dart';
import 'package:human_resources/features/review/componants/text_questions.dart';

class QuestionAndAnswerBuilder extends StatelessWidget {
  Map<String, dynamic> element;
  dynamic ans;
  QuestionAndAnswerBuilder({required this.element, required this.ans});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      child: itemBuilder(),
    );
  }

  Widget itemBuilder() {
    switch (element['type']) {
      case ('checkbox'):
        {
          CheckMarkQA _checkMarkQ = CheckMarkQA(
            name: element["name"],
            choices: element["choices"],
            answers: ans,
          );
          return _checkMarkQ;
        }
      case ('radiogroup'):
        {
          RadioGroupQA _radioGroupQ = RadioGroupQA(
            name: element["name"],
            choices: element["choices"],
            selected: ans,
          );
          return _radioGroupQ;
        }
      case ("text"):
        {
          TextQA _textQ = TextQA(
            name: element["name"],
            answer: ans,
          );
          return _textQ;
        }
      case ("file"):
        {
          FileQA _fileQ = FileQA(
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
