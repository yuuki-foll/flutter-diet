import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NextPage();
  }
}

class _NextPage extends State<NextPage> {
  File? _image;
  final imagePicker = ImagePicker();
  List<String> _tineLabels = ["朝", "昼", "夜", "その他"];
  String? _selectedKey;
  String _foodName = "";

  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("　　　　パス：" + pickedFile.path);
      }
    });
  }

  Future getImageFromLibrary() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("料理を追加"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //children以下のレイアウト間隔など
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? Text(
                      '写真を選択してください',
                      style: Theme.of(context).textTheme.headline4,
                    )
                  : Image.file(_image!),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                        onPressed: getImageFromCamera, //カメラで写真をとる
                        child: Icon(Icons.add_a_photo)),
                    FloatingActionButton(
                        onPressed: getImageFromLibrary, //アルバムから写真をとる
                        child: Icon(Icons.photo)),
                  ]),
              Text("料理名を入力:" + _foodName),
              Form(
                child: TextFormField(
                  decoration: InputDecoration(labelText: '料理名'),
                  onFieldSubmitted: (value) {
                    print(value);
                    setState(() {
                      _foodName = value;
                    });
                  },
                ),
              ),
              Text("↓食べた時間は?"),
              DropdownButton<String>(
                value: _selectedKey,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(fontSize: 20, color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedKey = newValue;
                  });
                },
                items:
                    _tineLabels.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ]),
      ),
    );
  }
}
