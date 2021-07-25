import 'package:flutter/material.dart';
import 'package:human_resources/base/navigation_bar.dart';
import 'package:human_resources/models/user.dart';

class DynamicApp extends StatefulWidget {
  final Widget body;
  final AppBar appBar;
  final Widget? floatingActionButton;
  // final User user;
  DynamicApp(
      {
      // required this.user,
      required this.appBar,
      required this.body,
      this.floatingActionButton});
  @override
  _DynamicAppState createState() => _DynamicAppState();
}

class _DynamicAppState extends State<DynamicApp> {
  @override
  Widget build(BuildContext context) {
    // User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      drawer: NavBar(
          // name: widget.user.name,
          // email: widget.user.email,
          // avatar: widget.user.img,
          ),
      appBar: widget.appBar,
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
