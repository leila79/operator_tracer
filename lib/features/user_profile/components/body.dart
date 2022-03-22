import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/features/user_profile/Bloc/bloc/user_bloc.dart';
import 'package:human_resources/features/user_profile/components/changePasswordButton.dart';
import 'package:human_resources/features/user_profile/components/profile_widget.dart';
import 'package:human_resources/models/user.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserBloc _bloc = UserBloc();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    _bloc.add(GetUserInfo());
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return Container(
              child: AlertDialog(
                title: Text('Somthing went wrong!!'),
                content: Text('Do you want to try again?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      Navigator.pushNamed(context, '/profileScreen');
                      // Navigator.of(context).pop(true);
                    },
                    /*Navigator.of(context).pop(true)*/
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          } else if (state is ShowLoading) {
            return Center(
                child: CircularProgressIndicator(
                    // color: Colors.transparent,
                    ));
          } else if (state is ShowUserInfo) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileWidget(
                      imagePath: state.user.img,
                      onClicked: () => SelectFileSource()),
                  SizedBox(
                    height: 24,
                  ),
                  buildText(state.user),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ChangePasswordButton(
                        text: 'Change Password',
                        onClicked: () {
                          Navigator.pushNamed(context, '/changePasswordScreen');
                        }),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildText(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  _getImage(ImageSource imageSource) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: imageSource,
      maxWidth: 90,
      maxHeight: 90,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _bloc.add(UploadImage(file: File(pickedFile.path)));
      });
    }
  }

  void SelectFileSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              _getImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              _getImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
