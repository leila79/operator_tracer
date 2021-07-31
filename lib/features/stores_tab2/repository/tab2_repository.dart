import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/database/models/checkList_db.dart';
import 'package:human_resources/database/models/items_db.dart';
import 'package:human_resources/models/checkList.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:human_resources/network/local.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Tab2Repository {
  List<CheckList> items = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<List<CheckList>> getItemData() async {
    var res = await LocalApiHelper().parseJson("checklists");
    final Box<CheckListDB> checklistBox = Hive.box('checklists');
    List temp = res['data'] as List;
    List<CheckList> tempStore = temp.map((e) => CheckList.fromJson(e)).toList();
    items = [];
    List<ItemDB> tempItems = [];
    items.addAll(tempStore);
    bool inHive = false;
    for (CheckList c in items) {
      inHive = false;
      if (checklistBox.isEmpty) {
        tempItems = [];
        for (CheckItem checkItem in c.items) {
          tempItems.add(ItemDB(
              checkItem.id,
              checkItem.title,
              checkItem.description,
              checkItem.date,
              checkItem.time,
              checkItem.status));
        }
        CheckListDB item = CheckListDB(c.id, c.storeId, tempItems);
        checklistBox.add(item);
      } else {
        for (CheckListDB i in checklistBox.values) {
          if (c.id == i.id) {
            inHive = true;
            break;
          }
        }
        if (inHive == false) {
          tempItems = [];
          for (CheckItem checkItem in c.items) {
            tempItems.add(ItemDB(
                checkItem.id,
                checkItem.title,
                checkItem.description,
                checkItem.date,
                checkItem.time,
                checkItem.status));
          }
          CheckListDB item = CheckListDB(c.id, c.storeId, tempItems);
          checklistBox.add(item);
        }
      }
    }
    return items;
  }

  Future<void> addItemData(CheckItem item) async {
    // var res = await LocalApiHelper().parseJson("items");
    // List temp = res['data'] as List;
    // List<CheckItem> tempStore = temp.map((e) => CheckItem.fromJson(e)).toList();
    // int id = tempStore[tempStore.length - 1].id;
    // // for (CheckItem c in items) {
    // id++;
    // item.id = id;
    // temp.add(item.toJson());
    // // }
    // res['data'] = temp;
    final path = await _localPath;
    print(path);
    final file = File("$path/items.json");
    file.writeAsStringSync(json.encode(item));
    print(file.readAsStringSync());
  }

  Future<void> deleteFiles() async {
    final path = await _localPath;
    print(path);
    final file = File("$path/items.json");
    file.writeAsStringSync('');
    print(file.readAsStringSync());
  }
}
