import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/signIn_page/welcome/component/RoundedButton.dart';
import 'package:human_resources/features/user_profile/Bloc/bloc/user_bloc.dart';
import 'package:human_resources/features/user_profile/components/input_field.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // String currentPassword = '';
  // bool currentPasswordHaveText = true;
  String password = '';
  bool haveTextPassword = true;

  UserBloc _bloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return body(size, "");
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewPassword) {
          Navigator.popAndPushNamed(context, '/profileScreen');
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return body(size, "Current Password is incorrect");
          } else if (state is ShowLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return body(size, "");
        },
      ),
    );
  }

  void check_inputs() {
    // if (currentPassword == '') {
    //   currentPasswordHaveText = false;
    // } else {
    //   currentPasswordHaveText = true;
    // }
    if (password == '') {
      haveTextPassword = false;
    } else {
      haveTextPassword = true;
    }
  }

  Widget body(Size size, String error) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Change Password',
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
          // InputField(
          //   haveText: currentPasswordHaveText,
          //   text: 'Current Password',
          //   onChange: (value) {
          //     currentPassword = value;
          //     print(currentPassword);
          //   },
          // ),
          // SizedBox(
          //   height: size.height * 0.03,
          // ),
          InputField(
            haveText: haveTextPassword,
            text: 'New Password',
            onChange: (value) {
              password = value;
              print(password);
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedButton(
            color: Colors.lightBlue,
            text: 'Change Password',
            onPress: () {
              setState(() {
                // haveTextPassword = false;
                // currentPasswordHaveText = false;
                check_inputs();
              });
              if (haveTextPassword) {
                _bloc.add(GetNewPassword(password: password));
                // _bloc.add(CheckCurrentPassword(password: currentPassword));
                // currentPassword = '';
                password = '';
              }
            },
          ),
        ],
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
      // } else if (!currentPasswordHaveText && !haveTextPassword) {
      //   error = 'Please Enter Your Current Password & New Password';
      // } else if (!currentPasswordHaveText) {
      //   error = 'Please Enter Your Current Password ';
    } else if (!haveTextPassword) {
      error = 'Please Enter Your New Password';
    }
    return Container();
  }
}
