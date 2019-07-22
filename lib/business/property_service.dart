import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';

Future getProperties() async{
  return Firestore.instance.collection(Collection.Properties).orderBy("order").getDocuments();
}