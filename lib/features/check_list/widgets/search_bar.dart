import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/features/check_list/bloc/check_list_bloc.dart';

class SearchBar extends StatefulWidget {
  String _searchText = "";

  @override
  _SearchBarState createState() => _SearchBarState();

  String getName() {
    return _searchText;
  }
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _filter = TextEditingController();
  List filteredNames = [];
  List<String> names = [];
  _SearchBarState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          widget._searchText = "";
          filteredNames = names;
          final checkListBloc = BlocProvider.of<CheckListBloc>(context);
          checkListBloc.add(GetSearchedData());
        });
      } else {
        setState(() {
          widget._searchText = _filter.text;
          final checkListBloc = BlocProvider.of<CheckListBloc>(context);
          checkListBloc.add(GetSearchedData());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              controller: _filter,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Search"),
            ),
          ),
          // Text(_searchText),
        ],
      ),
    );
  }
}
