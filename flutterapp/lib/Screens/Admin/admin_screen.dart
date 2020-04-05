import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/Admin/hall_issues.dart';
import 'package:flutterapp/Screens/maps_screen.dart';
import 'package:flutterapp/Screens/unity_screen.dart';

import 'package:flutterapp/Widgets/form_field.dart';
import 'package:flutterapp/utils/data_parser.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with TickerProviderStateMixin {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _hall = TextEditingController();

  TabController _nestedTabController;

  var data;
  var singledata;

  final CollectionReference collectionReference =
      Firestore.instance.collection("Notices");

  void writeNotice() {
    Map<String, String> data = <String, String>{
      "title": _title.text,
      "hall": _hall.text,
      "desc": _desc.text,
      "date": _date.text,
      'id': DateTime.utc(1).toString(),
    };
    collectionReference.add(data).whenComplete(() => Navigator.pop(context));
  }

  void getNotices() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("Notices").getDocuments();
    if (this.mounted) {
      setState(() {
        data = querySnapshot.documents;
        print(data.length);
      });
    }
  }

  void getNoticebyId(String id) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("Notices")
        .where("id", isEqualTo: id)
        .getDocuments();
    if (this.mounted) {
      setState(() {
        singledata = querySnapshot.documents;
      });
    }
  }

  void updateData(String id, newValues) {
    Firestore.instance
        .collection("Notices")
        .document()
        .updateData(newValues)
        .catchError((e) => print(e));
  }

  void deleteData(docId) {
    Firestore.instance
        .collection("Notices")
        .document(docId)
        .delete()
        .whenComplete(() => print("Deleted"))
        .catchError((e) => print(e));
  }

  @override
  void initState() {
    _nestedTabController = new TabController(length: 2, vsync: this);
    super.initState();
    this.getNotices();
    this.getNoticebyId(Dataparser.id);
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()));
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
                HallIssues(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          _showNoteDialog(context);
        },
        child: Icon(Icons.add),
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
                      SizedBox(height: 20)
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

  void _showNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add a notice'),
        content: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LabelTextField(
                hintText: "Enter the hall number",
                labelText: "Hall number",
                textEditingController: _hall,
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Title of notice",
                labelText: "Title",
                textEditingController: _title,
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Description of notice",
                labelText: "Description",
                textEditingController: _desc,
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Date",
                labelText: "Date",
                textEditingController: _date,
              ),
              SizedBox(height: 20),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    writeNotice();
                  },
                  child: Text("Submit"),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void _showEditDialog(BuildContext context, selectedDoc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add a notice'),
        content: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LabelTextField(
                hintText: "Enter the hall number",
                labelText: "Hall number",
                textEditingController: singledata[0]['hall'],
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Title of notice",
                labelText: "Title",
                textEditingController: _title,
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Description of notice",
                labelText: "Description",
                textEditingController: _desc,
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Date",
                labelText: "Date",
                textEditingController: _date,
              ),
              SizedBox(height: 20),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    updateData(Dataparser.id, {
                      "hall": this._hall,
                      "title": this._title,
                      "desc": this._desc,
                      "date": this._date
                    });
                  },
                  child: Text("Update"),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
