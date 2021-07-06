import 'package:flutter/material.dart';
import 'package:human_resources/models/store.dart';

class StoreItem extends StatelessWidget {
  final Store store;
  final int groupValue;
  final Function onTap;

  StoreItem(
      {required this.store, required this.groupValue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    IconData radioIcon = groupValue == store.id
        ? Icons.radio_button_checked
        : Icons.radio_button_off;
    return InkWell(
      onTap: () => onTap(),
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
          children: [
            Icon(radioIcon),
            SizedBox(
              width: 10.0,
            ),
            Text(store.name),
          ],
        ),
      ),
    );
  }
}
