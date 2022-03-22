import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/background.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/forgotPasswordButton.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedPasswordField.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedInputField.dart';
import 'package:human_resources/features/signIn_page/welcome/component/RoundedButton.dart';
import 'package:human_resources/features/signIn_page/Bloc/bloc/userAuth_bloc.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = '';
  bool haveTextEmail = true;

  UserAuthblocBloc _bloc = UserAuthblocBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewPassword) {
          Navigator.popAndPushNamed(context, '/userLoginPage');
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return body(size, "Username is incorrect");
          } else if (state is ShowLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return body(size, "");
        },
      ),
    );
  }

  Widget body(Size size, String error) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryLightColor,
        // flexibleSpace: Image(
        //   image: AssetImage('assets/images/background.jpg'),
        //   fit: BoxFit.cover,
        // ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // SvgPicture.asset(
              //   "assets/icons/login.svg",
              //   height: size.height * 0.35,
              // ),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              ErrorWidget(error, size),

              RoundedInputField(
                haveText: haveTextEmail,
                text: 'Username',
                onChange: (value) {
                  email = value;
                  print(email);
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedButton(
                text: 'Get Password',
                onPress: () {
                  if (email == '') {
                    setState(() {
                      haveTextEmail = false;
                    });
                  } else {
                    _bloc.add(GetNewPassword(email: email));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ErrorWidget(String error, Size size) {
    if (error != "") {
      return Column(
        children: [
          Container(
            child: Text(error),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      );
    }
    return Container();
  }
}
