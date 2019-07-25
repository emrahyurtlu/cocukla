import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String documentID;
  String name;
  String email;
  String password;
  String image;
  bool isActive;
  int role;

  UserModel(
      {this.documentID,
      this.name,
      this.email,
      this.password,
      this.isActive,
      this.role});

  UserModel.fromFirebaseUser(FirebaseUser user)
      : documentID = user.uid,
        name = user.displayName,
        email = user.email,
        image = user.photoUrl;

  Map<String, dynamic> toJson() => {
        "documentID": documentID,
        "name": name,
        "email": email,
        "password": password,
        "image": image,
        "isActive": isActive,
        "role": role,
      };

  @override
  String toString() {
    return 'UserModel{documentID: $documentID, name: $name, email: $email, password: $password, image: $image, isActive: $isActive, role: $role}';
  }
}
