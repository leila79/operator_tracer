import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/base/daynamicApp.dart';
import 'package:human_resources/features/check_list/bloc/check_list_bloc.dart';
import 'package:human_resources/features/check_list/widgets/filterDialog.dart';
import 'package:human_resources/features/check_list/widgets/item_builder.dart';
import 'package:human_resources/features/user_profile/Bloc/bloc/user_bloc.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:human_resources/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/search_bar.dart';

class CheckListPage extends StatefulWidget {
  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  late User user;
  String _searchText = "";
  SearchBar searchBar = SearchBar();
  TextEditingController _filter = TextEditingController();
  Connectivity _connectivity = Connectivity();
  String _connectionStatus = "";
  late StreamSubscription<ConnectivityResult> _connectionSubscription;
  bool filter = false;
  String catButton = "filter";
  String? day = "All";
  CheckListBloc _bloc = CheckListBloc();

  @override
  void initState() {
    _bloc.add(GetItemData());
    super.initState();
    // getUserInfo();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
    initConnectivity();
    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result.toString();
        if (_connectionStatus == "ConnectivityResult.mobile" ||
            _connectionStatus == "ConnectivityResult.wifi") {
          _connectionStatus = "connected";
        } else {
          _connectionStatus = "unable to connect";
        }
      });
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      setState(() {
        _connectionStatus = result.toString();
        if (_connectionStatus == "ConnectivityResult.mobile" ||
            _connectionStatus == "ConnectivityResult.wifi") {
          _connectionStatus = "connected";
        } else {
          _connectionStatus = "unable to connect";
        }
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // User user = ModalRoute.of(context)!.settings.arguments as User;
    _bloc.add(GetItemData());

    return DynamicApp(
      // user: user,
      appBar: AppBar(
        title: Text(
          'Check List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            color: Colors.white,
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        flexibleSpace: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is NOData) {
              return Text('NoData');
            } else if (state is ShowLoading) {
              return CircularProgressIndicator();
            } else if (state is ShowItems) {
              return itemBuilder(state.items);
            } else if (state is ShowSearchedItems) {
              String name = searchBar.getName();
              _searchText = name;
              return itemBuilder(state.items);
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form_page');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> allItems(List<CheckItem> items) {
    List<Widget> tempItems = [];

    tempItems.add(searchBar);
    tempItems.add(Row(
      children: [
        // connectivity status
        Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: _connectionStatus == "connected"
                ? Colors.green[700]
                : Colors.red,
          ),
          child: Text(
            _connectionStatus,
            style: TextStyle(color: Colors.white),
          ),
        ),
        // space between
        Expanded(child: Container()),
        // button to show the last 24 hour
        GestureDetector(
          child: Container(
            width: 100.0,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            color: Colors.blue,
            child: Text(
              catButton,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Filter(
                  day: day,
                  onChange: (value1) {
                    day = value1;
                    setState(() {
                      if (value1 != "All") {
                        filter = true;
                        catButton = "$value1";
                      } else {
                        filter = false;
                        catButton = "All";
                      }
                      Navigator.of(context).pop();
                    });
                  },
                );
              },
            );
          },
        )
      ],
    ));

    int numberOfDays = 1;

    switch (catButton) {
      case "24 Hours":
        numberOfDays = 1;
        break;
      case "48 Hours":
        numberOfDays = 2;
        break;
      case "1 Week":
        numberOfDays = 7;
        break;
      case "1 Month":
        numberOfDays = 30;
        break;
      case "3 Month":
        numberOfDays = 90;
        break;
    }

    if (_searchText != "") {
      for (int i = 0; i < items.length; i++) {
        if (items[i].title.contains(_searchText)) {
          if (filter) {
            DateTime today = DateTime.now();
            DateTime endDay = today.subtract(Duration(days: numberOfDays));
            DateTime date = DateTime.parse("${items[i].date} ${items[i].time}");
            if (date.isAfter(endDay)) {
              tempItems.add(ItemBuilder(
                item: items[i],
              ));
            }
          } else {
            tempItems.add(ItemBuilder(
              item: items[i],
            ));
          }
        }
      }
    } else {
      for (int i = 0; i < items.length; i++) {
        if (filter) {
          DateTime today = DateTime.now();
          DateTime endDay = today.subtract(Duration(days: numberOfDays));
          DateTime date = DateTime.parse("${items[i].date} ${items[i].time}");
          if (date.isAfter(endDay)) {
            tempItems.add(ItemBuilder(
              item: items[i],
            ));
          }
        } else {
          tempItems.add(ItemBuilder(
            item: items[i],
          ));
        }
      }
    }
    return tempItems;
  }

  Widget itemBuilder(List<CheckItem> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // items
          Expanded(
            child: ListView(
              children: allItems(items),
            ),
          ),
        ],
      ),
    );
  }
}
