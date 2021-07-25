import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';

class TextFieldContainer extends StatelessWidget {
  late final Widget child;
  late final bool haveText;

  TextFieldContainer({required this.child, required this.haveText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
          border: haveText ? null : Border.all(color: Colors.red)),
      child: child,
    );
  }
}
