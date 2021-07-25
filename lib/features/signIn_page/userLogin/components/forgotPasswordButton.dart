import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';

class ForgotPasswordButton extends StatelessWidget {
  late final VoidCallback onTap;
  ForgotPasswordButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Text(
            'Forgot Password',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
