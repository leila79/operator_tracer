import 'package:flutter/material.dart';
import 'package:human_resources/base/daynamicApp.dart';
import 'package:human_resources/features/user_profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicApp(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: Body(),
    );
    // return Scaffold(
    //   // drawer: NavBar(),
    // appBar: AppBar(
    //   title: Text(
    //     'Profile',
    //     style: TextStyle(
    //       color: Colors.black,
    //     ),
    //   ),
    //   centerTitle: true,
    //   backgroundColor: Colors.transparent,
    //     leading: Builder(
    //       builder: (context) => IconButton(
    //         color: Colors.white,
    //         icon: Icon(Icons.arrow_back),
    //         onPressed: () {
    //           Navigator.popAndPushNamed(context, '/main_page');
    //         },
    //       ),
    //     ),
    // flexibleSpace: Image(
    //   image: AssetImage('assets/images/background.jpg'),
    //   fit: BoxFit.cover,
    // ),
    //   ),
    //   body: Body(),
    // );
  }
}
