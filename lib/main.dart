import 'dart:io';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/phoneLogin/screens/phoneLogin.dart';
import 'package:human_resources/features/signIn_page/userLogin/screens/userLoginPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/database/items_db.dart';
import 'features/form/pages/form_page.dart';
import 'features/check_list/pages/check_list_page.dart';
import 'features/signIn_page/welcome/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ItemAdapter());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Operator Tracer',
    theme: ThemeData(
        primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
    initialRoute: '/',
    routes: {
      '/main_page': (context) => CheckListPage(),
      '/': (context) => WelcomePage(),
      '/check_list': (context) => CheckListPage(),
      '/form_page': (context) => FormPage(),
      '/userLoginPage': (context) => UserLoginPage(),
      '/phoneLoginPage': (context) => PhoneLoginPage(),
    },
  ));
}
