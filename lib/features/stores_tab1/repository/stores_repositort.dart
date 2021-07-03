import 'package:human_resources/models/store.dart';
import 'package:human_resources/network/local.dart';

class StoreRepository {
  List<Store> items = [];

  Future<List<Store>> getItemData() async {
    var res = await LocalApiHelper().parseJson("stores");
    List temp = res['data'] as List;
    List<Store> tempStore = temp.map((e) => Store.fromJson(e)).toList();
    items = [];
    items.addAll(tempStore);
    return items;
  }
}
