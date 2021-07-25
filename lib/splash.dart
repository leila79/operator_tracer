import 'package:flutter/material.dart';
import 'package:human_resources/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    check_if_loggedin();
  }

  check_if_loggedin() async {
    var loginData = await SharedPreferences.getInstance();
    bool status = (loginData.getBool('login') ?? true);

    print(status);
    if (status == false) {
      Navigator.pushReplacementNamed(
        context,
        '/main_page',
        arguments: User(
          loginData.getString('status')!,
          loginData.getString('id')!,
          loginData.getString('email')!,
          loginData.getString('name')!,
          loginData.getString('img')!,
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/welcomePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
