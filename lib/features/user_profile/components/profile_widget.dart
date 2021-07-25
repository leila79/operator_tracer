import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'dart:io';

class ProfileWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;

  ProfileWidget({
    required this.imagePath,
    required this.onClicked,
  });

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: biuldEditIcon(color),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    final image;
    if (widget.imagePath != '') {
      image = NetworkImage('https://movi.amwajco.net/${widget.imagePath}');
    } else {
      image = AssetImage('assets/images/unknown.png');
    }

    return ClipOval(
      child: Container(
        width: 128,
        height: 128,
        child: Image(
          image: image,
        ),
      ),
    );
  }

  Widget biuldEditIcon(Color color) => GestureDetector(
        onTap: widget.onClicked,
        child: buildCircle(
          all: 3,
          color: Colors.white,
          child: buildCircle(
            all: 8,
            color: color,
            child: Icon(
              Icons.edit,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle(
          {required Widget child, required double all, required Color color}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
