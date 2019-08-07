import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/utilities/console_message.dart';

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

  setRating(String documentID) async {
    var place = await getById(documentID);
    double rating = 0;
    if (place.comments != null) {
      for (var item in place.comments) {
        var model = CommentModel.from(item);
        rating += model.rating / place.comments.length;
      }
    }

    if (rating > 0) {
      await Firestore.instance
          .collection(Collections.Places)
          .document(documentID)
          .updateData({"rating": rating.toString()});
    }

    consoleLog("Rating is: $rating");
  }
}
