import 'dart:io';
import 'package:human_resources/database/models/answers_db.dart';
import 'package:human_resources/database/models/checkList_db.dart';
import 'package:human_resources/database/models/items_db.dart';
import 'package:human_resources/database/models/question_db.dart';
import 'package:human_resources/database/models/question_item_db.dart';
import 'package:human_resources/database/models/store_db.dart';
import 'package:human_resources/database/models/user_db.dart';
import 'package:human_resources/features/review/screens/review_page.dart';
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
import 'features/form/pages/form_page.dart';
import 'features/check_list/pages/check_list_page.dart';
import 'features/signIn_page/welcome/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ItemDBAdapter());
  Hive.registerAdapter(UserDBAdapter());
  Hive.registerAdapter(StoreDBAdapter());
  Hive.registerAdapter(CheckListDBAdapter());
  Hive.registerAdapter(QuestionItemDBAdapter());
  Hive.registerAdapter(QuestionDBAdapter());
  Hive.registerAdapter(AnswersDBAdapter());
  await Hive.openBox<UserDB>('user');
  await Hive.openBox<ItemDB>('items');
  await Hive.openBox<StoreDB>('stores');
  await Hive.openBox<CheckListDB>('checklists');
  await Hive.openBox<QuestionItemDB>('questionItem');
  await Hive.openBox<QuestionDB>('questions');
  await Hive.openBox<AnswersDB>('answers');
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    Hive.box('user').compact();
    Hive.box('items').compact();
    Hive.box('stores').compact();
    Hive.box('checklists').compact();
    Hive.box('questionItem').compact();
    Hive.box('questions').compact();
    Hive.box('answers').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
          '/reviewScreen': (context) => ReviewPage(),
        },
      ),
    );
  }
}
