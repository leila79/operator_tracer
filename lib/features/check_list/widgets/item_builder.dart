import 'package:flutter/material.dart';
import 'package:human_resources/features/check_list/widgets/check_list_item.dart';
import 'package:human_resources/models/check_item.dart';

class ItemBuilder extends StatelessWidget {
  final CheckItem item;
  ItemBuilder({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: itemBuilder(),
    );
  }

  Widget itemBuilder() {
    return CheckListItem(
      checkItem: item,
    );
  }
}
