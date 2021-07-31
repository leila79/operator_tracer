import 'package:hive/hive.dart';
import 'package:human_resources/database/models/items_db.dart';

part 'checkList_db.g.dart';

@HiveType(typeId: 3)
class CheckListDB {
  CheckListDB(this.id, this.storeId, this.items);

  @HiveField(0)
  int id;
  @HiveField(1)
  int storeId;
  @HiveField(2)
  List<ItemDB> items;
}
