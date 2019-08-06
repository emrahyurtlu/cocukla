import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/place_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/utilities/console_message.dart';

class UserService {
  CollectionReference _userRef =
      Firestore.instance.collection(Collections.Users);
  PlaceService _placeService = PlaceService();

  Future<void> insert(UserModel model) async {
    var data = model.toJson();
    var isExist = await userExist(model.email);
    if (isExist == false) await _userRef.document(model.email).setData(data);
  }

  Future<void> update(UserModel model) async {
    var data = model.toJson();
    var document = _userRef.document(model.email);
    if (document != null) document.updateData(data);
  }

  Future<bool> userExist(String email) async {
    bool result = false;
    await _userRef
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      result = snapshot.documents.length > 0;
    });
    return result;
  }

  Future<UserModel> getUser(String email) async {
    UserModel userModel = UserModel.iniDefault();
    var result = await _userRef.document(email).get();
    var data = result.data;
    userModel = UserModel.from(data);
    return userModel;
  }

  Future<bool> favorite(String email, String documentID) async {
    bool isFav = false;
    var favoriteList = List<String>();

    var user = _userRef.document(email);

    await user.get().then((DocumentSnapshot snapshot) {
      favoriteList = snapshot.data["favorites"] != null
          ? List<String>.from(snapshot.data["favorites"])
          : List<String>();

      for (var favorite in favoriteList) {
        if (favorite == documentID) {
          isFav = true;
          break;
        }
      }

      if (isFav) {
        //Unfav
        isFav = false;
        user.updateData({
          "favorites": FieldValue.arrayRemove([documentID])
        });
        log("Unfav");
        consoleLog("$email removed from favorites the place $documentID");
      } else {
        //Fav
        isFav = true;
        user.updateData({
          "favorites": FieldValue.arrayUnion([documentID])
        });
        log("Fav");
        consoleLog("$email added to favorites the place $documentID");
      }
    });

    return isFav;
  }

  Future<List<PlaceModel>> getFavorites(List<String> favorites) async {
    var places = List<PlaceModel>();
    var place = PlaceModel();
    if (favorites.length > 0) {
      for (var favorite in favorites) {
        place = await _placeService.getById(favorite);
        places.add(place);
      }
    }
    return places;
  }
}
