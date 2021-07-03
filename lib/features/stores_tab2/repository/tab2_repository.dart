import 'dart:convert';

import 'package:flutter/services.dart';
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
    List temp = res['data'] as List;
    List<CheckList> tempStore = temp.map((e) => CheckList.fromJson(e)).toList();
    items = [];
    items.addAll(tempStore);
    return items;
  }

  Future<void> addItemData(List<CheckItem> items) async {
    var res = await LocalApiHelper().parseJson("items");
    List temp = res['data'] as List;
    List<CheckItem> tempStore = temp.map((e) => CheckItem.fromJson(e)).toList();
    int id = tempStore[tempStore.length - 1].id;
    for (CheckItem c in items) {
      id++;
      c.id = id;
      temp.add(c.toJson());
    }
    res['data'] = temp;
    final path = await _localPath;
    print(path);
    final file = File("$path/items.json");
    file.writeAsStringSync(json.encode(res));
  }
}
