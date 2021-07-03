import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:human_resources/models/check_item.dart';

class CheckListItem extends StatelessWidget {
  final CheckItem checkItem;
  CheckListItem({required this.checkItem});

  Widget status() {
    if (checkItem.status == 'not done')
      return Icon(
        Icons.clear,
        size: 30.0,
      );
    else if (checkItem.status == 'done')
      return Icon(
        Icons.check,
        size: 30.0,
      );
    else
      return CircularProgressIndicator();
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          status(),
          SizedBox(
            width: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(checkItem.title),
              Text(checkItem.description),
            ],
          ),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(checkItem.date),
                  Icon(Icons.calendar_today),
                ],
              ),
              Row(
                children: [
                  Text(checkItem.time),
                  Icon(Icons.access_time),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
