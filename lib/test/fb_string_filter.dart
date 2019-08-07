import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:flutter/material.dart';

class FirebaseStringFilter extends StatefulWidget {
  @override
  _FirebaseStringFilterState createState() => _FirebaseStringFilterState();
}

class _FirebaseStringFilterState extends State<FirebaseStringFilter> {

  var _list = List<DocumentSnapshot>();

  Future<List<DocumentSnapshot>> getData() async {
    var documents = List<DocumentSnapshot>();
    await Firestore.instance
        .collection(Collections.Places)
        .getDocuments()
        .then((QuerySnapshot qs) {
      if (qs != null) {
        for (var document in qs.documents) {
          if (document.data["name"]
              .toString()
              .toLowerCase()
              .contains("Host".toLowerCase())) {
            documents.add(document);
            _list.add(document);
            consoleLog("Sonuç bulundu");
          };
        }
      }
    });

    return documents;
  }

  @override
  void initState() {

    getData().then((List<DocumentSnapshot> result){
      consoleLog(result[0].toString());
      _list = result;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          var item = _list[index];
          return ListTile(
            title: Text("deneme"),
          );
        },)
      )),
    );
  }
}
