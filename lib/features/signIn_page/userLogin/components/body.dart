import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/background.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedPasswordField.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedInputField.dart';
import 'package:human_resources/features/signIn_page/welcome/component/RoundedButton.dart';
import 'package:human_resources/features/signIn_page/Bloc/bloc/userbloc_bloc.dart';

class Body extends StatelessWidget {
  UserblocBloc _bloc = UserblocBloc();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
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
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedInputField(
                    text: 'Email',
                    onChange: (value) {},
                  ),
                  RoundedPasswordField(
                    onChange: (value) {},
                  ),
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
                  // LoginDifferently(
                  //   text: 'Phone Number',
                  //   onTap: () => Navigator.pushNamed(context, "/phoneLoginPage"),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
