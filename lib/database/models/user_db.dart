import 'package:hive/hive.dart';

part 'user_db.g.dart';

@HiveType(typeId: 0)
class UserDB {
  UserDB(
      {required this.status,
      required this.id,
      required this.email,
      required this.name,
      required this.img});

  @HiveField(0)
  String status;
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String email;
  @HiveField(4)
  String img;
}
