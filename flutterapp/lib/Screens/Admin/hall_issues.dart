import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/utils/data_parser.dart';

class HallIssues extends StatefulWidget {
  @override
  _HallIssuesState createState() => _HallIssuesState();
}

class _HallIssuesState extends State<HallIssues> {
  var data;
  var status;

  void getAllIssues() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("Issues").getDocuments();
    if (this.mounted) {
      setState(() {
        data = querySnapshot.documents;
        print(data.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getAllIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _singleNotice(),
    );
  }

  Widget _singleNotice() {
    return data != null && data.length != null && data.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: data.length != null ? data.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onLongPress: (){
                  print("change status");
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                          color: Color(0xff244475),
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              data[index]['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      ListTile(
                        leading: Text(
                          data[index]['hall'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(data[index]['date']),
                      ),
                      SizedBox(height: 20),
                     
                    ],
                  ),
                ),
              );
            },
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
