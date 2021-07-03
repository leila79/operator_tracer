import 'package:flutter/material.dart';
import 'package:human_resources/models/check_item.dart';

class StoreCheckListItem extends StatefulWidget {
  CheckItem checkItem;
  bool checked;
  StoreCheckListItem({required this.checkItem, required this.checked});

  @override
  _StoreCheckListItemState createState() => _StoreCheckListItemState();
}

class _StoreCheckListItemState extends State<StoreCheckListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.checked) {
            widget.checked = false;
          } else
            widget.checked = true;
        });
      },
      child: Container(
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
            Icon(widget.checked
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.checkItem.title),
                Text(widget.checkItem.description),
              ],
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(widget.checkItem.date),
                    Icon(Icons.calendar_today),
                  ],
                ),
                Row(
                  children: [
                    Text(widget.checkItem.time),
                    Icon(Icons.access_time),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
