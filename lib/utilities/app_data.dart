import 'package:cocukla/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class AppData {
  static Position position;
  static String coordinate = position != null
      ? position.latitude.toString() + "," + position.longitude.toString()
      : "";
  static List<Placemark> placemarks;

  static UserModel user;

  static FirebaseUser firebaseUser;

  static String homeSelectedCategory = "Mekanlar";
}
