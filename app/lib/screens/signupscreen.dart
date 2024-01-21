import 'package:flutter/material.dart';
import '../data.dart';
import 'package:spryzen/data.dart';
import 'package:spryzen/screens/login_screen.dart';

import '../app_bar.dart';

class Sign_up extends StatefulWidget {
  @override
  SetuppageState createState() => SetuppageState();
}

class SetuppageState extends State<Sign_up> {
  bool is_visibility = false;
  bool is_visibility2 = false;
  String _name = "", email = "";
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void settings(BuildContext ctxxxxx) {
    Navigator.of(ctxxxxx).push(
      MaterialPageRoute(
        builder: (_) {
          return Log_in();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(children: [
                TextFormField(
                  controller: _username,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return "Enter correct username with mimimum 4 characters";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(4), right: Radius.circular(4)),
                    ),
                    hintText: "Username",
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " enter the email address";
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return "Enter correct emailaddress";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                    hintText: "Email",
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: _password,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Enter correct password with minimum 8 characters";
                    } else {
                      return null;
                    }
                  },
                  obscureText: !is_visibility2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Create new Password",
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
                      ),
                      hintText: "Password"),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: _confirm,
                  obscureText: !is_visibility,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.toString() != _password.text.toString()) {
                      return "password mismatch";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Confirm the password",
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
                    ),
                    hintText: "Password",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String username = _username.text.toString();
                    String emailid = _email.text.toString();
                    String pass = _password.text.toString();
                    bool t = await Data.signUp(username, emailid, pass);

                    try {
                      if (formkey.currentState!.validate() && t) {
                        settings(context);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('SignUp'),
                ),
              ]),
            ),
          ),
        ),
      ),
    ));
  }
}
