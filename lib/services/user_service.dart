import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/services/base_service.dart';
import 'package:cocukla/services/helpers/login_helper.dart';
import 'package:cocukla/utilities/object_to_map_utility.dart';

class UserService extends LoginHelper implements BaseService<UserModel> {
  @override
  String collection;

  UserService.collection(this.collection);

  @override
  void delete(UserModel entity) {
    if(isLogin())
      print("Yes logged in!");
    // TODO: implement delete
  }

  @override
  UserModel get(List conditions) {
    // TODO: implement get
    return null;
  }

  @override
  List<UserModel> getList(List conditions) {
    // TODO: implement getList
    return null;
  }

  @override
  UserModel insert(UserModel entity) {
    Firestore.instance
        .collection(this.collection)
        .add(ConverterUtility.ObjecttoMap(entity));
    return null;
  }

  @override
  UserModel update(UserModel entity) {
    // TODO: implement update
    return null;
  }
}
