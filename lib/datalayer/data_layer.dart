import 'package:cloud_firestore/cloud_firestore.dart';

class DataLayer {
  Future<void> insert(String collection, Map data) {
    Firestore.instance
        .collection(collection)
        .add(data)
        .catchError((e) => print("DATABASE INSERT ERROR: " + e));
  }

  Future<void> update(String collection, Map data, String documentPath) {
    Firestore.instance
        .collection(collection)
        .document(documentPath)
        .updateData(data)
        .catchError((e) => print("DATABASE UPDATE ERROR: " + e));
  }

  Future<void> delete(String collection, String documentPath) {
    Firestore.instance
        .collection(collection)
        .document(documentPath)
        .delete()
        .catchError((e) => print("DATABASE DELETE ERROR: " + e));
  }

  Future<QuerySnapshot> getList(String collection) async {
    return await Firestore.instance
        .collection(collection)
        .getDocuments()
        .catchError((e) => print("DATABASE GET-LIST ERROR: " + e));
  }

  Future<DocumentSnapshot> get(String collection, String documentID) async {
    return await Firestore.instance
        .collection(collection)
        .document(documentID)
        .get(source: Source.serverAndCache)
        .catchError((e) => print("DATABASE GET ERROR: " + e));
  }
}
