import 'package:flutter/material.dart';

import 'notices_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainScreenBody(),
    );
  }

  Widget _mainScreenBody() {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoticeScreen()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Get start",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.indigo,
        ),
      ),
    );
  }
}
