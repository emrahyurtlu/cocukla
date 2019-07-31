import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String documentID;
  String name;
  String email;
  String image;
  String city;
  String district;
  bool isAuthorized;
  Timestamp insertDate;
  Timestamp updateDate;

  UserModel(
      {this.documentID,
      this.email,
      this.name,
      this.image,
      this.city,
      this.district,
      this.isAuthorized,
      this.insertDate,
      this.updateDate});

  UserModel.from(FirebaseUser user)
      : documentID = user.uid,
        name = user.displayName,
        email = user.email,
        image = user.photoUrl;

  Map<String, dynamic> toJson() => {
        "documentID": documentID,
        "name": name,
        "email": email,
        "image": image,
        "city": city,
        "district": district,
        "isAuthorized": isAuthorized,
        "insertDate": insertDate,
        "updateDate": updateDate,
      };

  @override
  String toString() {
    return 'UserModel{documentID: $documentID, name: $name, email: $email, image: $image, city: $city, district: $district, isAuthorized: $isAuthorized, insertDate: $insertDate, updateDate: $updateDate}';
  }
}
