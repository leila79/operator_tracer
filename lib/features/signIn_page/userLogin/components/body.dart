import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/background.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/forgotPasswordButton.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedPasswordField.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/roundedInputField.dart';
import 'package:human_resources/features/signIn_page/welcome/component/RoundedButton.dart';
import 'package:human_resources/features/signIn_page/Bloc/bloc/userAuth_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = '';
  bool haveTextEmail = true;

  String password = '';
  bool haveTextPassword = true;
  bool _isLoading = false;

  // String error = '';
  UserAuthblocBloc _bloc = UserAuthblocBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ShowUserInfo) {
          Navigator.pushReplacementNamed(context, '/main_page',
              arguments: state.user);
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return LoadingOverlay(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: body(size, "Username or password is incorrect"),
                ),
              ),
              isLoading: _isLoading,
              // demo of some additional parameters
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(),
            );
            // return body(size, "Username or password is incorrect");
          } else if (state is ShowLoading) {
            // _isLoading = true;
            return LoadingOverlay(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: body(size, ''),
                ),
              ),
              isLoading: true,
              // demo of some additional parameters
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(),
            );
          } else if (state is ConnectionError) {
            // email = '';
            // password = '';
            return LoadingOverlay(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: body(size, 'connection error'),
                ),
              ),
              isLoading: _isLoading,
              // demo of some additional parameters
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(),
            );
            // return body(size, 'connection error');
          }
          // else {
          //   email = '';
          //   password = '';
          // }
          // else if (state is ShowUserInfo) {
          //   return Container();
          // }
          return LoadingOverlay(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: body(size, ''),
              ),
            ),
            isLoading: _isLoading,
            // demo of some additional parameters
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void check_inputs() {
    if (email == '') {
      haveTextEmail = false;
    } else {
      haveTextEmail = true;
    }
    if (password == '') {
      haveTextPassword = false;
    } else {
      haveTextPassword = true;
    }
  }

  Widget body(Size size, String error) {
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
            ErrorWidget(error),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              text: 'Username',
              haveText: haveTextEmail,
              onChange: (value) {
                email = value;
                print(email);
              },
            ),
            RoundedPasswordField(
              haveText: haveTextPassword,
              onChange: (value) {
                password = value;
                print(password);
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              text: 'LOGIN',
              onPress: () {
                // print(email);
                // print(password);
                setState(() {
                  check_inputs();
                });
                if (haveTextEmail && haveTextPassword) {
                  _bloc.add(CheckUserInfo(email: email, password: password));
                  // email = '';
                  // password = '';
                }
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            // LoginDifferently(
            //   text: 'Phone Number',
            //   onTap: () => Navigator.pushNamed(context, "/phoneLoginPage"),
            // )
            ForgotPasswordButton(
              onTap: () => Navigator.pushNamed(context, "/forgetPasswordPage"),
            ),
          ],
        ),
      ),
    );
  }

  Widget ErrorWidget(String error) {
    // print(error);
    // if (error != "") {
    //   return Container(
    //     child: Text(error),
    //   );
    // } else
    if (!haveTextEmail && !haveTextPassword) {
      error = 'Please Enter Your Email & Password';
    } else if (!haveTextEmail) {
      error = 'Please Enter Your Email';
    } else if (!haveTextPassword) {
      error = 'Please Enter Your Password';
    }
    return Container(
      child: Text(error),
    );
  }
}
