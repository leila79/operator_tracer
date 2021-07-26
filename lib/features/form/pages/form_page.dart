import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_resources/features/form/widgets/tab4.dart';
import 'package:human_resources/features/questions_tab3/bloc/question_bloc.dart';
import 'package:human_resources/features/questions_tab3/page/tab3.dart';
import 'package:human_resources/features/stores_tab1/pages/tab1.dart';
import 'package:human_resources/features/stores_tab2/page/tab2.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  FirstTab firstTab = FirstTab();
  SecondTab secondTab = SecondTab(0);
  ThirdTab thirdTab = ThirdTab();
  late Widget tab;
  int tabNum = 1;
  int pageNum = 0;

  void initState() {
    tab = choose(1);
    super.initState();
  }

  _back() {
    setState(() {
      tabNum--;
      print(tabNum);
      if (tabNum <= 0) {
        thirdTab.deleteCache();
        Navigator.pop(context);
        tabNum = 1;
      }
      if (tabNum == 3) {
        pageNum -= 2;
      }
      if (tabNum == 2) {
        if (pageNum > 1) {
          tabNum = 3;
          pageNum -= 2;
        }
      }

      tab = choose(tabNum);
    });
  }

  _next() {
    setState(() {
      if (tabNum == 2) {
        pageNum = 0;
      }
      tabNum++;
      print(tabNum);
      if (tabNum > 4) {
        thirdTab.deleteCache();
        Navigator.pop(context);
        tabNum = 4;
      }
      tab = choose(tabNum);
    });
  }

  _exit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              Navigator.of(context).pop(true);
            },
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget choose(int tab) {
    if (tab == 1) {
      return firstTab;
    }
    if (tab == 2) {
      secondTab.selected_store_id = firstTab.selected;
      return secondTab;
    }
    if (tab == 3) {
      print('Page num : $pageNum');
      if (pageNum == 0) {
        print('in if');
        secondTab.save();
      }
      pageNum++;
      thirdTab.savePage();
      thirdTab.pageNum = pageNum;
      thirdTab.checklistNum = secondTab.selected;
      thirdTab.bloc.add(
          GetQuestionsData(pageNum: pageNum, checklistNum: secondTab.selected));
      return thirdTab;
    }
    if (tab == 4) {
      thirdTab.savePage();
      thirdTab.save();
      pageNum++;
      thirdTab.pageNum = pageNum;
      thirdTab.bloc.add(
          GetQuestionsData(pageNum: pageNum, checklistNum: secondTab.selected));
      if (!thirdTab.bloc.done) {
        tabNum = 3;
        return thirdTab;
      } else {
        return FourthTab();
      }
    } else {
      return Container();
    }
  }

  Color _color(int tab) {
    if (tab < tabNum) {
      return Colors.green;
    } else if (tab == tabNum) {
      return Colors.red;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
                stops: [0.4, 0.4],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 50, 40, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 10.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: _color(1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Stores',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 10.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: _color(2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Check Lists',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 10.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: _color(3),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Questions',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 10.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: _color(4),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Done',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: tab),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: _back,
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
                                onPressed: _next,
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
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            onPressed: () => _exit(),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                minimumSize: Size(130, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: Text(
                              'Exit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
