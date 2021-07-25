import 'package:flutter/material.dart';
import '../../../base/navigation_bar.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            color: Colors.white,
            icon: Icon(Icons.check_circle),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Main',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Text('this is the main page'),
      ),
    );
  }
}
