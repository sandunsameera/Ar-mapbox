import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CameraApp())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/unity.png'),fit: BoxFit.fill),
        ),
      ),
    );
  }
}
