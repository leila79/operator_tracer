import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';

class RoundedButton extends StatelessWidget {
  late final String text;
  late final VoidCallback onPress;
  final Color color, textColor;

  RoundedButton({
    required this.text,
    required this.onPress,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            backgroundColor: color,
          ),
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
