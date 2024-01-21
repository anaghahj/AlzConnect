import 'package:flutter/material.dart';

import 'package:spryzen/draw.dart';
import 'package:spryzen/screens/mainscreen.dart';
import 'package:spryzen/screens/login_screen.dart';
import 'package:spryzen/screens/imagescreen.dart';
import 'package:spryzen/screens/videoscreenmain.dart';

class APPBAR extends StatefulWidget {
  const APPBAR({super.key});
  @override
  State<StatefulWidget> createState() {
    return _APPBARState();
  }
}

class _APPBARState extends State<APPBAR> {
  void newscreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return mainscreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.image)),
                Tab(icon: Icon(Icons.video_camera_back)),
              ],
            ),
            title: const Text(
              "SPRYZEN",
              textScaleFactor: 1.0,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  print('pressed');
                },
                icon: const Icon(Icons.account_circle_rounded),
              ),
            ]),
        drawer: appdrawer(),
        body: TabBarView(
          children: [mainscreen(), mainvideoscreen()],
        ),
      ),
    );
  }
}
