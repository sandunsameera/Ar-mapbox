import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Widgets/form_field.dart';
import 'package:flutterapp/utils/data_parser.dart';

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
    collectionReference.add(data).whenComplete(() => {Navigator.pop(context)});
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
        .delete().whenComplete(()=>print("Deleted"))
        .catchError((e) => print(e));
  }

  @override
  void initState() {
    super.initState();
    this.getNotices();
    this.getNoticebyId(Dataparser.id);
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
                      ListTile(
                        leading: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {
                            Dataparser.id = data[index]['id'];
                            _showEditDialog(context,Dataparser.id);
                            }),
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              Dataparser.id = data[index]['id'];
                              print(data[index]['id']);
                              deleteData(data[index]['id']);
                            }),
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
