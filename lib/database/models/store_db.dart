import 'package:hive/hive.dart';

part 'store_db.g.dart';

@HiveType(typeId: 2)
class StoreDB {
  StoreDB(this.id, this.name);

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
}
