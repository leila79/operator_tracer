import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';

class LoginDifferently extends StatelessWidget {
  late final String text;
  late final VoidCallback onTap;
  LoginDifferently({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login with ',
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          child: Text(
            text,
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
