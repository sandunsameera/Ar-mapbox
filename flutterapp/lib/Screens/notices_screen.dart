import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/single_notice.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _singleNotice(),
    );
  }

  Widget _singleNotice() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (BuildContext context,int index) {
        return InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SingleNotice())),
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                    color: Color(0xff244475),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "Notice header $index",
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
                SizedBox(height: 20)
              ],
            ),
          ),

        );
      },
    );
  }
}
