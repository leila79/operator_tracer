import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/database/items_db.dart';
import 'package:human_resources/models/check_item.dart';
import 'package:human_resources/network/check_item_api.dart';
import 'package:human_resources/network/client.dart';
import 'package:human_resources/network/local.dart';

class ItemRepository {
  List<CheckItem> items = [];
  late Dio client;

  ItemRepository() {
    // client = Client().init();
  }

  Future<List<CheckItem>> getItemData() async {
    var res = await LocalApiHelper().parseJson("items");
    List temp = res['data'] as List;
    List<CheckItem> tempProduct =
        temp.map((e) => CheckItem.fromJson(e)).toList();
    items = [];
    items.addAll(tempProduct);
    Item item = Item(
        tempProduct[0].id,
        tempProduct[0].title,
        tempProduct[0].description,
        tempProduct[0].date,
        tempProduct[0].time,
        tempProduct[0].status);
    // var box = await Hive.openBox<Item>('item');
    // box.add(item);
    // final value = box.values.toList();
    // print(box.values.toList()[0].title);
    // print(value);
    // await box.deleteFromDisk();
    return items;
  }

  Future<List<CheckItem>> fetchAllItemData() async {
    Response response = await fetchAll(client);
    return List<CheckItem>.from(
      (response.data).map((e) => CheckItem.fromJson(e)),
    );
  }

  Future<CheckItem> fetchCheckItem(String objectId) async {
    Response response = await fetch(client, objectId);
    return CheckItem.fromJson(response.data);
  }

  Future<CheckItem> addCheckItem(CheckItem checkItem) async {
    Response response = await add(client, checkItem.toJson());
    return CheckItem.fromJson(response.data);
  }

  Future<Response> deleteCheckItem(String objectId) async {
    return await delete(client, objectId);
  }

  Future<Response> updateCheckItem(String objectId, CheckItem checkItem) async {
    return await update(client, objectId, checkItem.toJson());
  }

  Future<Response> uploadImage(String path, String fileName) async {
    return await postImage(client, path, fileName);
  }
}
