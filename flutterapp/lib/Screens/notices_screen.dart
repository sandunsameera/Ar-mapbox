import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/single_notice.dart';
import 'package:flutterapp/utils/data_parser.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  var data;

  void getNotices() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("Notices").getDocuments();
    if (this.mounted) {
      setState(() {
        data = querySnapshot.documents;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getNotices();
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
                onTap: () {
                  Dataparser.id = data[index]['id'].toString();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SingleNotice()));
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Dataparser.id = data[index]['id'].toString();
                          print(Dataparser.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleNotice()));
                        },
                        child: Container(
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
                      ),
                      ListTile(
                        onTap: (){
                          Dataparser.id = data[index]['id'].toString();
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SingleNotice()));
                        },
                        leading: Text(
                          data[index]['hall'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(data[index]['date']),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              );
            },
          )
        : Container(
            child: Center(
                child: InkWell(
              child: Text("Currently no notices"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleNotice())),
            )),
          );
  }
}
