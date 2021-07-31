import 'package:flutter/material.dart';
import 'package:human_resources/features/review/componants/body.dart';
import 'package:human_resources/models/check_item.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CheckItem;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Review',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: Body(
        checkItem: args,
      ),
    );
  }
}
