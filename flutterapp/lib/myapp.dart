import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/login_screen.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:LoginPage()
    );
  }
}
