import 'package:flutter/material.dart';
import 'package:spryzen/app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spryzen/data.dart';
import 'package:spryzen/screens/videoscreen.dart';
import 'package:spryzen/screens/login_screen.dart';
import 'package:spryzen/screens/signupscreen.dart';
import 'package:spryzen/screens/splashscreen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 168, 184, 255),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

Future<void> mainApp() async {
  const MaterialApp(
    title: 'SpryZen',
    initialRoute: '/',
    home: Scaffold(
      body: Text("no connection"),
    ),
  );
}

Future<void> main() async {
  bool check = await Data.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash_screen(),
        theme: ThemeData(
          primaryColorLight: Color.fromRGBO(255, 207, 131, 110),
          colorScheme: theme.colorScheme, // Set the colorScheme from your theme
          textTheme: theme.textTheme,
        ));
  }
}
