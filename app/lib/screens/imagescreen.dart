import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spryzen/app_bar.dart';
import 'package:spryzen/screens/mainscreen.dart';

import '../data.dart';
import '../image_get.dart';

class imagescreen extends StatefulWidget {
  @override
  _imagescreenState createState() => _imagescreenState();
}

class _imagescreenState extends State<imagescreen> {
  /// Variables
  File? imageFile;
  final _picker = ImagePicker();
  void _pickImagebase() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    Uint8List imagebyte = await image!.readAsBytes();
    String base64 = base64Encode(imagebyte);
    print(base64);
    bool img = await Data.insertImage(base64);
    if (img) {
      imageget();
      print("imagestored");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _pickImagebase();
                            newscreen(context);
                          },
                          child: Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )));
  }

  void newscreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      var image;
      return APPBAR();
    }));
  }
}
