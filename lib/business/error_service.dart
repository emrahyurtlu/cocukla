import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';

saveError(String message) {
  Firestore.instance.collection(Collections.Errors).add({"content": message});
}
