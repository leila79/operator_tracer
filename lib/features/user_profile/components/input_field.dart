import 'package:flutter/material.dart';
import 'package:human_resources/features/signIn_page/constants.dart';
import 'package:human_resources/features/signIn_page/userLogin/components/textFieldContainer.dart';

class InputField extends StatefulWidget {
  late final ValueChanged<String> onChange;
  late String text;
  late final bool haveText;
  InputField({
    required this.onChange,
    required this.haveText,
    required this.text,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passVisibility = false;
  FocusNode _passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        // color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
        border: widget.haveText
            ? Border.all(color: Colors.black)
            : Border.all(color: Colors.red),
      ),
      // haveText: widget.haveText,
      child: TextField(
        // autofocus: false,
        // focusNode: _passFocus,
        obscureText: !_passVisibility,
        decoration: InputDecoration(
          hintText: widget.text,
          icon: Icon(
            Icons.lock,
            color: Colors.blue[700],
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passVisibility ? Icons.visibility_off : Icons.visibility,
              color: Colors.blue[700],
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
