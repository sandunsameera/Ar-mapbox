import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/single_notice.dart';
import 'package:flutterapp/Widgets/form_field.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _hall = TextEditingController();

  var data;

  final CollectionReference collectionReference =
      Firestore.instance.collection("Notices");

  void writeNotice() {
    Map<String, String> data = <String, String>{
      "title": _title.text,
      "hall": _hall.text,
      "desc": _desc.text,
      "date": _date.text,
    };
    collectionReference.add(data).whenComplete(() => {
      Navigator.pop(context)
    });
  }

  void getNotices() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("Notices").getDocuments();
    data = querySnapshot.documents;
    print(data.length);
  }

  @override
  void initState() {
    this.getNotices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _singleNotice(),
      floatingActionButton: FloatingActionButton(
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
            itemCount: data != null && data.length != null && data.length > 0
                ? data.length
                : 0,
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
              child: Text("Currently no notices"),
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
}
