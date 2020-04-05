import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/User/compose_issues.dart';
import 'package:flutterapp/Screens/User/single_notice.dart';
import 'package:flutterapp/Screens/maps_screen.dart';
import 'package:flutterapp/Screens/unity_screen.dart';
import 'package:flutterapp/utils/data_parser.dart';

import '../../main.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen>
    with TickerProviderStateMixin {
  // static final GoogleSignIn _googleSignIn = GoogleSignIn();
  var data;
  TabController _nestedTabController;

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
  // GoogleSignInAccount _user = _googleSignIn.currentUser;
  void initState() {
    _nestedTabController = new TabController(length: 2, vsync: this);
    super.initState();
    this.getNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: IconButton(
                    icon: Icon(
                      Icons.camera_enhance,
                      color: Colors.teal,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    }),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                child: IconButton(
                    icon: Icon(
                      Icons.map,
                      color: Colors.teal,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          TabBar(
            controller: _nestedTabController,
            indicatorColor: Colors.indigo,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Text("Notices"),
              ),
              Tab(
                child: Text("Hall issues"),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.80,
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                _singleNotice(),
                ComposeIssue(),
              ],
            ),
          )
        ],
      ),
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
                        onTap: () {
                          Dataparser.id = data[index]['id'].toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleNotice()));
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
              child: CircularProgressIndicator(),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleNotice())),
            )),
          );
  }
}
