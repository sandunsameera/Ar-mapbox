import 'package:flutter/material.dart';

class SingleNotice extends StatefulWidget {
  @override
  _SingleNoticeState createState() => _SingleNoticeState();
}

class _SingleNoticeState extends State<SingleNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _singleNoticeBody(),
    );
  }

  Widget _singleNoticeBody() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff244475),
              child: Center(
                child: Text(
                  "Notice header 1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "This is the description",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        ListTile(
          leading: Text("Date :"),
          trailing: Text("Date"),
        ),
        SizedBox(height: 20),
        Center(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            highlightColor: Colors.green,
          ),
        )
      ],
    );
  }
}
