import 'package:hive/hive.dart';

part 'items_db.g.dart';

@HiveType(typeId: 0)
class Item {
  Item(
      this.id, this.title, this.description, this.date, this.time, this.status);

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String date;
  @HiveField(4)
  String time;
  @HiveField(5)
  String status;
}
