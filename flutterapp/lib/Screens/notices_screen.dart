import 'package:flutter/material.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _noticeList(),
    );
  }

  Widget _noticeList() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 16)),
          _singleNotice(),
          SizedBox(height: 8),
          _singleNotice()
        ],
      ),
    );
  }

  Widget _singleNotice() {
    return InkWell(
      onTap: ()=>print("Fuck off"),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
                color: Color(0xff244475),
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Notice header 1",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            ListTile(
              leading: Text("Date"),
              trailing: Text("Some fuck"),
            ),
          ],
        ),
      ),
    );
  }
}
