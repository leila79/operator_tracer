import 'package:flutter/material.dart';

class TextQA extends StatefulWidget {
  String name;
  late String answer = "";
  TextQA({required this.name, required this.answer});
  @override
  _TextQAState createState() => _TextQAState();
}

class _TextQAState extends State<TextQA> {
  // late TextEditingController _controller;

  void initState() {
    super.initState();
    // _controller = new TextEditingController(text: widget.answer);
  }

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
        children: [
          Text(widget.name),
          Text(widget.answer
              // controller: _controller,
              // onChanged: (String value) {
              //   setState(() {
              //     widget.answer = value;
              //   });
              // },
              )
        ],
      ),
    );
  }
}
