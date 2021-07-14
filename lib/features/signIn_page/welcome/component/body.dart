import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:human_resources/features/signIn_page/welcome/component/RoundedButton.dart';
import 'package:human_resources/features/signIn_page/welcome/component/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Operator Tracer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            onPress: () => Navigator.pushNamed(context, "/userLoginPage"),
            text: 'Login With Username & Password',
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          // RoundedButton(
          //   text: 'Login With Phone Number',
          //   onPress: () => Navigator.pushNamed(context, "/phoneLoginPage"),
          //   color: kPrimaryLightColor,
          //   textColor: Colors.black,
          // )
        ],
      ),
    );
  }
}
