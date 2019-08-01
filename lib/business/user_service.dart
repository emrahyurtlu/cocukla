import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/utilities/app_data.dart';

bool favorite(String email, String documentID) {
  bool fav = false;
  DocumentSnapshot entity;
  var emails = [];
  var ref =
      Firestore.instance.collection(Collections.Places).document(documentID);

  ref.get().then((DocumentSnapshot document) {
    entity = document;

    emails = List<String>.from(document.data["favorites"]);
    if (emails.contains(email)) {
      //UnFav
      emails.remove(email);
      entity.data["favorites"] = emails;
      ref.updateData(entity.data);
    } else {
      //Fav
      emails.add(email);
      entity.data["favorites"] = emails;
      ref.updateData(entity.data);
      fav = true;
    }
  });
  return fav;
}

bool userCanApprove(String email) {
  Firestore.instance
      .collection(Collections.UserGranted)
      .where("email", isEqualTo: email)
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    if (snapshot.documents.length > 0) {
      AppData.canApprove = true;
    }
  });
  return AppData.canApprove;
}

class UserService {
  CollectionReference userRef =
      Firestore.instance.collection(Collections.Users);

  Future<void> insert(UserModel model) async {
    var data = model.toJson();
    var isExist = await userExist(model.email);
    if (isExist == false) await userRef.add(data);
  }

  Future<bool> userExist(String email) async {
    bool result = false;
    await userRef
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      result = snapshot.documents.length > 0;
    });
    return result;
  }

  Future<UserModel> get(String email) async {
    UserModel userModel = UserModel.iniDefault();
    var result = await userRef.where("email", isEqualTo: email).getDocuments();
    var data = await result.documents[0].data;
    userModel = UserModel.from(data);
    return userModel;
  }
}
