import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/stores_tab1/bloc/stores_bloc.dart';
import 'package:human_resources/features/stores_tab1/widgets/store_item_builder.dart';
import 'package:human_resources/models/store.dart';

class FirstTab extends StatefulWidget {
  int selected = 1;

  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  StoresBloc _bloc = StoresBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.add(GetStoresData());
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return Text('NoData');
          } else if (state is ShowLoading) {
            return CircularProgressIndicator();
          } else if (state is ShowStores) {
            return itemBuilder(state.stores);
          }
          return Container();
        },
      ),
    );
  }

  List<Widget> allItems(List<Store> stores) {
    List<Widget> items = [];

    items.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Choose the store',
        style: TextStyle(
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
    ));

    for (Store store in stores) {
      items.add(StoreItemBuilder(
        store: store,
        groupValue: widget.selected,
        onTap: () {
          setState(() {
            widget.selected = store.id;
          });
        },
      ));
    }
    return items;
  }

  Widget itemBuilder(List<Store> stores) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // items
          Expanded(
            child: ListView(
              children: allItems(stores),
            ),
          ),
        ],
      ),
    );
  }
}
