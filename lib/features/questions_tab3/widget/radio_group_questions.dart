import 'package:flutter/material.dart';

class RadioGroupQ extends StatefulWidget {
  String name;
  List choices;
  String? selected = "";
  RadioGroupQ({required this.name, required this.choices, this.selected});
  @override
  _RadioGroupQState createState() => _RadioGroupQState();
}

class _RadioGroupQState extends State<RadioGroupQ> {
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
        children: RadioGroup(),
      ),
    );
  }

  List<Widget> RadioGroup() {
    List<Widget> items = [];
    items.add(Text(widget.name));
    for (String c in widget.choices) {
      items.add(RadioListTile<String>(
          title: Text(c),
          value: c,
          groupValue: widget.selected,
          onChanged: (String? val) {
            setState(() {
              widget.selected = val;
            });
          }));
    }
    return items;
  }
}
