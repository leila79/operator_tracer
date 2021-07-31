import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/questions_tab3/bloc/question_bloc.dart';
import 'package:human_resources/features/questions_tab3/widget/question_builder.dart';
import 'package:human_resources/models/question_item.dart';

class ThirdTab extends StatefulWidget {
  final QuestionBloc bloc = QuestionBloc();
  final List<QuestionBuilder> _all = [];
  List<QuestionBuilder> _items = [];
  final Map<String, dynamic> answer = {};
  int pageNum = 1;
  int checklistNum = 1;
  @override
  _ThirdTabState createState() => _ThirdTabState();

  void save() {
    print('in save');
    for (QuestionBuilder q in _all) {
      q.value();
      if (q.element['type'] == 'checkbox') {
        answer[q.element['name']] = q.listAnswer;
      }
      if (q.element['type'] == 'radiogroup') {
        answer[q.element['name']] = q.answer;
      }
      if (q.element['type'] == 'text') {
        answer[q.element['name']] = q.answer;
      }
      if (q.element['type'] == 'file') {
        answer[q.element['name']] = q.listAnswer;
      }
    }
    bloc.add(AddAnswerData(answer: answer));
  }

  void savePage() {
    print('in save page');
    Map<String, dynamic> pageAnswers = {};
    // print(_items);
    for (QuestionBuilder q in _items) {
      q.value();
      if (q.element['type'] == 'checkbox') {
        pageAnswers[q.element['name']] = q.listAnswer;
      }
      if (q.element['type'] == 'radiogroup') {
        pageAnswers[q.element['name']] = q.answer;
      }
      if (q.element['type'] == 'text') {
        pageAnswers[q.element['name']] = q.answer;
      }
      if (q.element['type'] == 'file') {
        pageAnswers[q.element['name']] = q.listAnswer;
      }
    }
    bloc.add(AddPageData(answer: pageAnswers, pageNum: pageNum));
  }

  void deleteCache() {
    print("deleting the catch");
    bloc.add(DeleteFile(pageNum: pageNum));
  }
}

class _ThirdTabState extends State<ThirdTab> {
  void initState() {
    widget.bloc.add(GetQuestionsData(
        pageNum: widget.pageNum, checklistNum: widget.checklistNum));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is ShowLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NOData) {
            return Text('NOData');
          } else if (state is ShowPageData) {
            Widget items = itemBuilder(state.questions, state.answers);
            return items;
          } else {
            return Container();
          }
        },
      ),
    );
  }

  List<Widget> allItems(
      List<QuestionItem> questionItems, Map<String, dynamic> answers) {
    widget._items = [];
    for (QuestionItem q in questionItems) {
      for (Map<String, dynamic> e in q.elements) {
        QuestionBuilder question = QuestionBuilder(
          element: e,
          oldAns: answers[e['name']],
        );
        widget._items.add(question);
        widget._all.add(question);
      }
    }
    return widget._items;
  }

  Widget itemBuilder(
      List<QuestionItem> questionItems, Map<String, dynamic> answers) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // items
          Expanded(
            child: ListView(
              children: allItems(questionItems, answers),
            ),
          ),
        ],
      ),
    );
  }
}
