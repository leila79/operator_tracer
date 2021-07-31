import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/database/models/question_item_db.dart';
import 'package:human_resources/features/review/bloc/bloc/review_bloc.dart';
import 'package:human_resources/features/review/componants/questionBuilder.dart';
import 'package:human_resources/models/check_item.dart';

class Body extends StatefulWidget {
  CheckItem checkItem;

  Body({required this.checkItem});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ReviewBloc _bloc = ReviewBloc();
  int pageIndex = 0;
  late int numPages;
  @override
  void initState() {
    super.initState();
    _bloc.add(GetCheckListData(checkItem: widget.checkItem));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return Container();
          } else if (state is ShowLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShowCheckListData) {
            Map<String, dynamic> ans = state.answers.answer;
            List<QuestionItemDB> questionItem = state.question.pages;
            String storeName = state.store.name;
            return Container(
              child: buildItems(ans, questionItem, storeName),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildItems(Map<String, dynamic> answers,
      List<QuestionItemDB> questionItems, String storeName) {
    List<Widget> items = [];
    var ans;
    numPages = questionItems.length;
    QuestionItemDB questionItem = questionItems[pageIndex];
    // for (QuestionItemDB questionItem in questionItems) {
    for (Map<String, dynamic> element in questionItem.elements) {
      // print(element['type']);
      for (String name in answers.keys) {
        if (name == element['name']) {
          // print(element['name']);
          // print(element['choices']);
          ans = answers[name];
          items.add(QuestionAndAnswerBuilder(element: element, ans: ans));
        }
      }
      // }
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: ListView(
              children: items,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pageIndex--;
                      if (pageIndex < 0) {
                        pageIndex = 0;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: Size(130, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  child: Text(
                    'back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pageIndex++;
                      if (pageIndex > numPages - 1) {
                        pageIndex = numPages - 1;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey[700],
                      minimumSize: Size(130, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  child: Text(
                    'next',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
