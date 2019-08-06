import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/models/enums/enums.dart';

class UserModel {
  String name;
  String email;
  String image;
  String city;
  String district;
  LoginType loginType;
  bool isAuthorized;
  Timestamp insertDate;
  Timestamp updateDate;
  List<String> favorites;

  UserModel(
      {this.email,
      this.name,
      this.image,
      this.city,
      this.district,
      this.isAuthorized = false,
      this.insertDate,
      this.updateDate,
      this.loginType,
      this.favorites});

  UserModel.from(Map<String, dynamic> map)
      : email = map["email"],
        name = map["name"],
        image = map["image"],
        city = map["city"],
        district = map["district"],
        isAuthorized = map["isAuthorized"],
        insertDate = map["insertDate"],
        updateDate = map["updateDate"],
        loginType = LoginType.values[map["loginType"]],
        favorites = map["favorites"] != null ? List<String>.from(map["favorites"]) : [];

  UserModel.iniDefault() {
    this.email = "hesap@domain.com";
    this.name = "Kullanıcı";
    this.image = "";
    this.city = "Ankara";
    this.district = "Çankaya";
    this.isAuthorized = false;
    this.insertDate = Timestamp.now();
    this.updateDate = Timestamp.now();
    this.loginType = LoginType.None;
    this.favorites = [];
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "image": image,
        "city": city,
        "district": district,
        "isAuthorized": isAuthorized,
        "insertDate": insertDate,
        "updateDate": updateDate,
        "loginType": loginType.index,
        "favorites": favorites,
      };

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, image: $image, city: $city, district: $district, loginType: $loginType, isAuthorized: $isAuthorized, insertDate: $insertDate, updateDate: $updateDate, favorites: $favorites}';
  }


}
