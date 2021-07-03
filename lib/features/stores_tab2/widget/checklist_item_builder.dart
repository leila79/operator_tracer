import 'package:flutter/material.dart';
import 'package:human_resources/features/stores_tab2/widget/checklist_items.dart';
import 'package:human_resources/models/check_item.dart';

class ChecklistItemBuilder extends StatelessWidget {
  CheckItem item;
  ChecklistItemBuilder({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      child: Container(),
    );
  }

  // Widget itemBuilder() {
  //   // var temp = StoreCheckListItem(item);
  //   // return temp;
  // }
}
