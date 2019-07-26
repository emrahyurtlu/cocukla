import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoute {
  static String signIn = "/sign-in";
  static String signUp = "/sign-up";
  static String home = "/home";
  static String forgetPassword = "/forget-password";
  static String placeDetail = "/place-detail";
  static String profilePage = "/my-profile";
  static String myPlaces = "/my-places";
  static String addPlace = "/add-place";
}

redirecTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}
