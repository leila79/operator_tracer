import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:human_resources/features/signIn_page/phoneLogin/components/background.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/loginDifferently.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedInputField.dart';
import 'package:human_resources/features/signIn_page/welcome/component/RoundedButton.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // RoundedInputField(
            //   text: 'Phone Number',
            //   onChange: (value) {},
            // ),
            // RoundedPasswordField(
            //   onChange: (value) {},
            // ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              text: 'LOGIN',
              onPress: () => Navigator.pushNamed(context, '/main_page'),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            LoginDifferently(
              text: 'Username & Password',
              onTap: () => Navigator.pushNamed(context, "/userLoginPage"),
            )
          ],
        ),
      ),
    );
  }
}
