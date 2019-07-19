import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/data_layer.dart';

abstract class BaseService<T> {
  String collection;
  DataLayer dataLayer;

  Future<void> insert(Map data);

  Future<void> update(Map data, String documentPath);

  Future<void> delete(String documentPath);

  Future<DocumentSnapshot> get(String documentID);

  Future<QuerySnapshot> getList();
}
