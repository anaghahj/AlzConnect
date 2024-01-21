import 'package:flutter/material.dart';
import 'package:spryzen/listset.dart';

class setting_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: listset(),
    );
  }
}
