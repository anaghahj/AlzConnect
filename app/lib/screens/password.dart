import 'package:flutter/material.dart';

import 'package:spryzen/screens/setting_screen.dart';

import '../data.dart';

class Password extends StatefulWidget {
  final String Passwordtitle;
  Password(this.Passwordtitle);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool is_visibility = false;
  bool is_visibility2 = false;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  TextEditingController _newpassword = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void dispose() {
    _password.dispose();
    _newpassword.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void newscre(BuildContext ctxxx) {
    Navigator.of(ctxxx).push(
      MaterialPageRoute(
        builder: (_) {
          return setting_screen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        appBar: AppBar(title: Text(widget.Passwordtitle)),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Enter the new password'),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _newpassword,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return "Enter correct password with minimum 8 characters";
                      } else {
                        return null;
                      }
                    },
                    obscureText: !is_visibility,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              is_visibility = !is_visibility;
                            });
                          },
                          icon: is_visibility
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        )),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Confirm the password'),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _confirm,
                    validator: (value) {
                      if (value!.isEmpty || value != _newpassword.text) {
                        return "password mismatch";
                      } else {
                        return null;
                      }
                    },
                    obscureText: !is_visibility2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              is_visibility2 = !is_visibility2;
                            });
                          },
                          icon: is_visibility2
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          Data.changePwd(_confirm.text);
                          newscre(context);
                          const snackBar = SnackBar(
                            content: Text('Password Changed'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('Submit')),
                ],
              ),
            ),
          ),
        ));
  }
}
