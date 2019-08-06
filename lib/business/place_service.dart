import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/place_model.dart';

class PlaceService {
  CollectionReference _placeRef =
      Firestore.instance.collection(Collections.Places);

  Future<PlaceModel> getById(String documentID) async {
    var model = PlaceModel();
    DocumentSnapshot document = await _placeRef.document(documentID).get();
    if (document != null)
      model = PlaceModel.from(data: document.data, documentID: documentID);
    return model;
  }
}
