import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/database/items_db.dart';
import 'features/form/pages/form_page.dart';
import 'features/check_list/pages/check_list_page.dart';
import 'features/signIn_page/pages/signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ItemAdapter());

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/main_page': (context) => CheckListPage(),
      '/': (context) => SignInPage(),
      '/check_list': (context) => CheckListPage(),
      '/form_page': (context) => FormPage(),
    },
  ));
}
