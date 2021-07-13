import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/textFieldContainer.dart';

class RoundedPasswordField extends StatelessWidget {
  late final ValueChanged<String> onChange;
  RoundedPasswordField({
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
        onChanged: onChange,
      ),
    );
  }
}
