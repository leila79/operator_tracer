import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  Function(String?)? onChange;
  String? day;
  List<DropdownMenuItem<String>> items = [
    DropdownMenuItem<String>(
      child: Text("All"),
      value: "All",
    ),
    DropdownMenuItem<String>(
      child: Text("24 Hours"),
      value: "24 Hours",
    ),
    DropdownMenuItem<String>(
      child: Text("48 Hours"),
      value: "48 Hours",
    ),
    DropdownMenuItem<String>(
      child: Text("1 Week"),
      value: "1 Week",
    ),
    DropdownMenuItem<String>(
      child: Text("1 Month"),
      value: "1 Month",
    ),
    DropdownMenuItem<String>(
      child: Text("3 Month"),
      value: "3 Month",
    ),
  ];

  Filter({required this.onChange, required this.day});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.open_in_browser),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Container(
              height: 100.0,
              child: Column(
                children: [
                  Text("choose the number of days you want"),
                  SizedBox(
                    height: 10.0,
                    width: 10.0,
                  ),
                  DropdownButton<String>(
                    value: day,
                    items: this.items,
                    onChanged: onChange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
