import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FileQ extends StatefulWidget {
  String name;
  int maxSize;
  late String type = "";
  late String content = "";
  FileQ({required this.name, required this.maxSize});
  @override
  _FileQState createState() => _FileQState();
}

class _FileQState extends State<FileQ> {
  String _error = 'No Error Detected';
  String _fileName = "No file chosen";
  late String _filePath = '';
  List<Asset> images = <Asset>[];
  File? imageFile;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;

      _filePath =
          _paths != null ? _paths!.map((e) => e.path).toString() : '...';
      _filePath = _filePath.substring(1, _filePath.length - 1);
      if (_paths!.first.extension == 'jpg') {
        imageFile = File(_filePath);
      }
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      widget.content =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      widget.type =
          _paths != null ? _paths!.map((e) => e.extension).toString() : '...';
    });
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(widget.name),
          Row(
            children: [
              Expanded(child: Text(_fileName)),
              TextButton(
                onPressed: () => SelectFileSource(),
                child: Text('Choose'),
              )
            ],
          ),
          Container(
            height: 100.0,
            child: imageFile != null ? Image.file(imageFile!) : buildGridView(),
          )
        ],
      ),
    );
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
              _getFromCamera();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              loadAssets();
            },
          ),
          ListTile(
            leading: Icon(Icons.drive_file_move),
            title: Text("File"),
            onTap: () {
              Navigator.pop(context);
              imageFile = null;
              images = <Asset>[];
              _openFileExplorer();
            },
          ),
        ],
      ),
    );
  }
}
