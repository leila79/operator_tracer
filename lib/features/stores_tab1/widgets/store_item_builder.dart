import 'package:flutter/material.dart';
import 'package:human_resources/features/stores_tab1/widgets/store_item.dart';
import 'package:human_resources/models/store.dart';

class StoreItemBuilder extends StatelessWidget {
  Store store;
  Function onTap;
  int groupValue;
  StoreItemBuilder(
      {required this.store, required this.onTap, required this.groupValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      child: itemBuilder(),
    );
  }

  Widget itemBuilder() {
    return StoreItem(
      groupValue: groupValue,
      onTap: onTap,
      store: store,
    );
  }
}
