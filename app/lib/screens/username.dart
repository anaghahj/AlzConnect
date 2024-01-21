import 'package:flutter/material.dart';

import '../data.dart';

class Username extends StatelessWidget {
  final String usernametitle;
  String username = Data.getUsername();
  Username(this.usernametitle);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(usernametitle)),
      body: Column(
        children: [
          Center(
            child: Icon(
              Icons.account_circle_rounded,
              size: 100,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text('Username'),
            subtitle: Text(username),
            onTap: () => _username(),
          ),
        ],
      ),
    );
  }
}

void _username() {
  setState() => TextField(
        expands: true,
      );
}
