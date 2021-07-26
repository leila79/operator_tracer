import 'dart:io';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/phoneLogin/screens/phoneLogin.dart';
import 'package:human_resources/features/signIn_page/userLogin/screens/forgotPasswordPage.dart';
import 'package:human_resources/features/signIn_page/userLogin/screens/userLoginPage.dart';
import 'package:human_resources/features/user_profile/changePasswordScreen.dart';
import 'package:human_resources/features/user_profile/userscreen.dart';
import 'package:human_resources/splash.dart';
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
  // Hive.openBox<Item>('items');
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print('object');
        // FocusScopeNode currentFocus = FocusScope.of(context);

        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // }
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Operator Tracer',
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        initialRoute: '/splashPage',
        routes: {
          '/splashPage': (context) => Splash(),
          '/main_page': (context) => CheckListPage(),
          '/welcomePage': (context) => WelcomePage(),
          '/check_list': (context) => CheckListPage(),
          '/form_page': (context) => FormPage(),
          '/userLoginPage': (context) => UserLoginPage(),
          '/phoneLoginPage': (context) => PhoneLoginPage(),
          '/forgetPasswordPage': (context) => ForgotPassword(),
          '/profileScreen': (context) => ProfileScreen(),
          '/changePasswordScreen': (context) => ChangePassword(),
        },
      ),
    );
  }
}
