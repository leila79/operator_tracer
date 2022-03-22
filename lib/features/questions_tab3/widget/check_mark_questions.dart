import 'package:flutter/material.dart';

class CheckMarkQ extends StatefulWidget {
  final String name;
  final List choices;
  late final List<String> answers;
  final List<CheckBox> all = [];
  CheckMarkQ(
      {required this.name, required this.choices, required this.answers});
  @override
  _CheckMarkQState createState() => _CheckMarkQState();

  List<String> getValues() {
    // answers = [];
    answers.clear();
    print('answers');
    for (CheckBox c in all) {
      if (c.val == true) {
        answers.add(c.text);
      }
    }
    return answers;
  }
}

class _CheckMarkQState extends State<CheckMarkQ> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        children: CheckMark(),
      ),
    );
  }

  List<Widget> CheckMark() {
    List<Widget> items = [];
    items.add(Text(widget.name));
    for (String c in widget.choices) {
      CheckBox checkBox = CheckBox(text: c);
      checkBox.val = widget.answers.contains(checkBox.text) ? true : false;
      items.add(checkBox);
      widget.all.add(checkBox);
    }
    return items;
  }
}

class CheckBox extends StatefulWidget {
  bool? val = false;
  String text;
  CheckBox({required this.text});
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          widget.val = value;
        });
      },
      value: widget.val,
      title: Text(widget.text),
    );
  }
}
