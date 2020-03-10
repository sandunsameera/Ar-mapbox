import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/utils/data_parser.dart';

class SingleNotice extends StatefulWidget {
  @override
  _SingleNoticeState createState() => _SingleNoticeState();
}

class _SingleNoticeState extends State<SingleNotice> {

  var data;

  void getNotices(String id) async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("Notices").where("id",isEqualTo: id).getDocuments();
    data = querySnapshot.documents;
    print(data);
  }

  @override
  void initState() {
    this.getNotices(Dataparser.id);
    super.initState();
    print(data);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _singleNoticeBody(),
    );
  }

  Widget _singleNoticeBody() {
    return data!=null && data.length!=null && data.length>0?Column(
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
                  data[0]['title'] != null?data[0]['title']:"Still loading",
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
              data[0]['desc'] != null?data[0]['desc']:"Still loading",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        ListTile(
          leading: Text("Date :"),
          trailing: Text(data[0]['date']!= null?data[0]['desc']:"Still loading"),
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
    ):Container(
      child: Center(
        child: Text("Fuck off"),
      ),
    );
  }
}
