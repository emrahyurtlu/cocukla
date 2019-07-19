/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/base_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/datalayer/data_layer.dart';
import 'package:cocukla/models/user_model.dart';

import 'helpers/login_helper.dart';
*/

/*
class UserService extends LoginHelper implements BaseService<UserModel> {
  @override
  String collection = Collection.Users;

  @override
  DataLayer dataLayer = DataLayer();

  @override
  void delete(String documentPath) {
    dataLayer.delete(collection, documentPath);
  }

  @override
  Future<DocumentSnapshot> get(String documentID) {
    UserModel model;
    dataLayer.get(collection, documentID).then((document) {
      model = UserModel(
          uid: document.documentID,
          name: document["name"],
          email: document["email"],
          password: document["password"],
          role: document["role"]);
      print("USER SERVICE => " + model.toString());
    });
    return model;
  }

  @override
  List<UserModel> getList() {
    List<UserModel> users;
    dataLayer.getList(collection).then((QuerySnapshot result) {
      for (int i = 0; i < result.documents.length; i++) {
        var document = result.documents[i];
        var model = UserModel(
            uid: document.documentID,
            name: document["name"],
            email: document["email"],
            password: document["password"],
            role: document["role"]);
        users.add(model);
      }
    });
    return users;
  }

  @override
  void insert(Map data) {
    dataLayer.insert(collection, data);
  }

  @override
  void update(Map data, String documentPath) {
    dataLayer.update(collection, data, documentPath);
  }
}
*/
