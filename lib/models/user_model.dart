import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String password;
  String avatar;
  bool isActive;
  int role;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.isActive,
      this.role});

  UserModel.fromFirebaseUser(FirebaseUser user)
      : uid = user.uid,
        name = user.displayName,
        email = user.email,
        avatar = user.photoUrl;
}
