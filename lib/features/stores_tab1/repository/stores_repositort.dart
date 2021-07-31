import 'package:hive/hive.dart';
import 'package:human_resources/database/models/store_db.dart';
import 'package:human_resources/models/store.dart';
import 'package:human_resources/network/local.dart';

class StoreRepository {
  List<Store> items = [];

  Future<List<Store>> getItemData() async {
    var res = await LocalApiHelper().parseJson("stores");
    final Box<StoreDB> storeBox = Hive.box('stores');
    List temp = res['data'] as List;
    List<Store> tempStore = temp.map((e) => Store.fromJson(e)).toList();
    items = [];
    items.addAll(tempStore);
    bool inHive = false;
    for (Store s in items) {
      inHive = false;
      if (storeBox.isEmpty) {
        StoreDB item = StoreDB(s.id, s.name);
        storeBox.add(item);
      } else {
        for (StoreDB i in storeBox.values) {
          if (s.id == i.id) {
            inHive = true;
            break;
          }
        }
        if (inHive == false) {
          StoreDB item = StoreDB(s.id, s.name);
          storeBox.add(item);
        }
      }
    }
    return items;
  }
}
