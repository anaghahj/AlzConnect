import 'package:flutter/material.dart';

import 'package:spryzen/screens/username.dart';
import 'package:spryzen/screens/password.dart';

import 'package:spryzen/screens/about.dart';

import 'data.dart';

class listset extends StatelessWidget {
  final String usernametile = "Account";

  String email2id = Data.getemailid().toString();

  final String changepasstile = "CHANGEPASSWORD";
  final String abouttile = "ABOUT";

  listset();
  void user_name(BuildContext ctx, title) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Username(title);
        },
      ),
    );
  }

  void pass_word(BuildContext ctxx, String title) {
    Navigator.of(ctxx).push(
      MaterialPageRoute(
        builder: (_) {
          return Password(title);
        },
      ),
    );
  }

  void about(BuildContext ctxxx, String title) {
    Navigator.of(ctxxx).push(
      MaterialPageRoute(
        builder: (_) {
          return About(title);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<String> emailidt = Data.getemailid();
    return InkWell(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.account_circle_rounded,
              size: 36,
            ),
            title: Text(usernametile),
            onTap: () => user_name(context, usernametile),
          ),
          ListTile(
            leading: Icon(
              Icons.email_sharp,
            ),
            title: Text(
              'Email ID',
            ),
            subtitle: Text(
              "user123@gmail.com",
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.password_rounded,
            ),
            onTap: () => pass_word(context, changepasstile),
            title: Text('Change password'),
          ),
          ListTile(
            leading: Icon(
              Icons.info,
            ),
            onTap: () => about(context, abouttile),
            title: Text(
              'About',
            ),
          ),
        ],
      ),
    );
  }
}
