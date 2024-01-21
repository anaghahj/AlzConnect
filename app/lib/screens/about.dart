import 'dart:io';

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final String abouttile;
  About(this.abouttile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(abouttile)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(
                  'Introducing "AlzConnect": Your Personal Emotional Companion for Alzheimers Support MemoriaCare is a compassionate and intuitive app designed to provide unwavering emotional support for Alzheimers patients and their caregivers.',
                  textAlign: TextAlign.justify),
              Text(
                  'With a heartfelt focus on preserving cherished memories and maintaining a sense of connection, MemoriaCare offers a unique blend of features to make the Alzheimers journey a more meaningful and manageable experience.',
                  textAlign: TextAlign.justify),
              SizedBox(
                height: 20,
              ),
              Text(
                'Key Features:',
                textAlign: TextAlign.justify,
              ),
              Text('Memories Unveilded:', textAlign: TextAlign.justify),
              Text(
                  'Empower your journey by creating a beautiful digital scrapbook. Easily upload photos, videos, and personal mementos to construct a vibrant tapestry of cherished memories. Whether its reliving a family vacation or celebrating a special occasion, MemoriaCare allows you to capture and revisit moments that matter most.',
                  textAlign: TextAlign.justify),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
