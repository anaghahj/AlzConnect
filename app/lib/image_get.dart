import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'data.dart';

class imageget extends StatefulWidget {
  imageget({super.key});
  int i = 0;
  @override
  _imagegetState createState() => _imagegetState();
}

class _imagegetState extends State<imageget> {
  int i = 0;
  int j = 0;
  @override
  Widget build(BuildContext context) {
    getImage();
    int index = 0;

    if (images.isNotEmpty && index < images.length) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 10.0),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return images[index];
          },
        ),
      );
    } else {
      return const Text(
        "no images added",
        textScaleFactor: 3.0,
      );
    }
  }

  List<Image> images = [];
  getImage() {
    List<dynamic> base641 = Data.sendImages();

    int i;
    for (i = 0; i < base641.length; i++) {
      var bytes = const Base64Decoder().convert(base641[i]);

      Image image1 = (Image.memory(bytes));
      images.add(image1);
    }
    return images;
  }
}
