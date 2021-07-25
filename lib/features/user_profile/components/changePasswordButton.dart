import 'package:flutter/material.dart';

class ChangePasswordButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  ChangePasswordButton({required this.text, required this.onClicked});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        shape: StadiumBorder(),
      ),
    );
  }
}
