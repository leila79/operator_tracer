import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("signed in method"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/main_page");
                },
                child: Text("sing-in with username and password"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("sing-in with phone number"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
