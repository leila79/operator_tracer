import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/stores_tab2/bloc/stores2_bloc.dart';
import 'package:human_resources/features/stores_tab2/widget/checklist_item_builder.dart';
import 'package:human_resources/features/stores_tab2/widget/checklist_items.dart';
import 'package:human_resources/models/checkList.dart';
import 'package:human_resources/models/check_item.dart';

class SecondTab extends StatefulWidget {
  int selected_store_id;
  Stores2Bloc _bloc = Stores2Bloc();
  int selected = 1;
  List<StoreCheckListItem> items = [];
  SecondTab(this.selected_store_id);

  @override
  _SecondTabState createState() => _SecondTabState();

  void save() {
    late CheckItem select;
    // selected = '';
    for (StoreCheckListItem i in items) {
      if (i.value == selected) {
        print(i.checkItem.title);
        selected = i.value;
        select = i.checkItem;
        _bloc.add(AddData(item: select));
        // selected.add(i.checkItem.title);
      }
    }
  }
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    widget._bloc.add(GetChecklistData());
    return BlocProvider.value(
      value: widget._bloc,
      child: BlocBuilder(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is NOData) {
            return Text('NoData');
          } else if (state is ShowLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ShowChecklistData) {
            return itemBuilder(state.checkList);
          }
          return Container();
        },
      ),
    );
  }

  List<Widget> allItems(List<CheckList> checklist) {
    List<Widget> items = [];
    widget.items = [];

    items.add(Text(
      'Check the ones you want',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0),
    ));
    StoreCheckListItem temp;
    for (CheckList item in checklist) {
      if (item.storeId == widget.selected_store_id) {
        for (CheckItem i in item.items) {
          // if (widget.selected.contains(i.title)) {
          //   temp = StoreCheckListItem(
          //     checkItem: i,
          //     // checked: true,
          //   );
          // } else {
          //   temp = StoreCheckListItem(
          //     checkItem: i,
          //     // checked: false,
          //   );
          // }
          temp = StoreCheckListItem(
              checkItem: i,
              value: i.id,
              selected: widget.selected,
              onChange: () {
                setState(() {
                  widget.selected = i.id;
                });
              });
          widget.items.add(temp);

          items.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
            child: temp,
          ));
        }
      }
    }
    return items;
  }

  Widget itemBuilder(List<CheckList> checklist) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // items
          Expanded(
            child: ListView(
              children: allItems(checklist),
            ),
          ),
        ],
      ),
    );
  }
}
