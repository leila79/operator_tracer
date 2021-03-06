import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/textFieldContainer.dart';

class RoundedPasswordField extends StatefulWidget {
  late final ValueChanged<String> onChange;
  late final bool haveText;
  RoundedPasswordField({
    required this.onChange,
    required this.haveText,
  });

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passVisibility = false;
  FocusNode _passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      haveText: widget.haveText,
      child: TextField(
        // autofocus: false,
        // focusNode: _passFocus,
        obscureText: !_passVisibility,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passVisibility ? Icons.visibility_off : Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed: () {
              // _passFocus.unfocus();
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _passVisibility = !_passVisibility;
              });
            },
          ),
          border: InputBorder.none,
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
