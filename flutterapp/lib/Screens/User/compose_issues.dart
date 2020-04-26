import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Widgets/form_field.dart';
import 'package:flutterapp/utils/data_parser.dart';

class ComposeIssue extends StatefulWidget {
  @override
  _ComposeIssueState createState() => _ComposeIssueState();
}

class _ComposeIssueState extends State<ComposeIssue> {
  TextEditingController _hall = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _index_no = TextEditingController();
  TextEditingController _date = TextEditingController();

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

  var data;
  final CollectionReference collectionReference =
      Firestore.instance.collection("Issues");

  void writeIssue() {
    Map<String, String> data = <String, String>{
      "title": _title.text,
      "hall": _hall.text,
      "index_no": _index_no.text,
      "date": _date.text,
      "status":"Inprogress",
      'id': DateTime.utc(1).toString(),
    };
    collectionReference.add(data).whenComplete(() {
      print("Success");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _singleIssue(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
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
                hintText: "Title of issue",
                labelText: "Title",
                textEditingController: _title,
              ),
              SizedBox(height: 20),
              LabelTextField(
                hintText: "Your index number",
                labelText: "2017/cs/xxx",
                textEditingController: _index_no,
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
                    writeIssue();
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

  Widget _singleIssue() {
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
                      SizedBox(height: 20),
                       Align(
                          alignment: Alignment.center,
                          child: Text(data[index]['status'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
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
}
