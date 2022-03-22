import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/textFieldContainer.dart';

class RoundedInputField extends StatelessWidget {
  late final IconData icon;
  late final String text;
  late final ValueChanged<String> onChange;
  late final bool haveText;

  RoundedInputField(
      {this.icon = Icons.person,
      required this.text,
      required this.onChange,
      required this.haveText});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      haveText: haveText,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            hintText: text,
            border: InputBorder.none),
        onChanged: onChange,
      ),
    );
  }
}
