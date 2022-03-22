import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/database/models/items_db.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:human_resources/network/check_item_api.dart';
import 'package:human_resources/network/local.dart';
import 'package:path_provider/path_provider.dart';

class ItemRepository {
  List<CheckItem> items = [];
  late Dio client;

  ItemRepository() {
    // client = Client().init();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<List<CheckItem>> getItemData() async {
    var res = await LocalApiHelper().parseJson("items");
    List temp = res['data'] as List;
    final Box<ItemDB> itemBox = Hive.box('items');
    List<CheckItem> tempProduct =
        temp.map((e) => CheckItem.fromJson(e)).toList();
    items = [];
    items.addAll(tempProduct);
    final path = await _localPath;
    print(path);
    final file = File("$path/items.json");
    bool exist = await file.exists();
    print(exist);
    if (exist) {
      String add = file.readAsStringSync();
      print(add);
      if (add != '') {
        var item = json.decode(add);
        CheckItem checkItem = CheckItem.fromJson(item);
        items.add(checkItem);
        print(checkItem.title);
        file.writeAsString('');
      }
    }

    bool inHive = false;
    for (CheckItem c in items) {
      inHive = false;
      if (itemBox.isEmpty) {
        ItemDB item =
            ItemDB(c.id, c.title, c.description, c.date, c.time, c.status);
        itemBox.add(item);
      } else {
        for (ItemDB i in itemBox.values) {
          if (c.id == i.id) {
            inHive = true;
            break;
          }
        }
        if (inHive == false) {
          ItemDB item =
              ItemDB(c.id, c.title, c.description, c.date, c.time, c.status);
          itemBox.add(item);
        }
      }
    }
    items = [];
    for (ItemDB checkItem in itemBox.values) {
      items.add(CheckItem(checkItem.id, checkItem.title, checkItem.description,
          checkItem.date, checkItem.time, checkItem.status));
    }
    return items;
  }
}
