import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

var _auth = FirebaseAuth.instance;

Future<UserModel> signInWithGoogle() async {
  var googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final GoogleSignInAccount googleAccount = await googleSignIn.signIn();

  var googleSignInAuthentication = await googleAccount.authentication;

  var credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  var result = await _auth.signInWithCredential(credential);
  assert(result != null);
  var user = UserModel(
      name: result.user.displayName,
      image: result.user.photoUrl,
      email: result.user.providerData[1].email);
  AppData.user = user;

  return user;
}

Future<UserModel> signInWithFacebook() async {
  UserModel userModel;
  final login = FacebookLogin();
  login.loginBehavior = FacebookLoginBehavior.nativeOnly;

  var result = await login.logInWithReadPermissions(['email']);

  if (result.status == FacebookLoginStatus.loggedIn) {
    final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);

    await _auth.signInWithCredential(credential).then((AuthResult result) {
      userModel = UserModel(
          name: result.user.displayName,
          image: result.user.photoUrl + "?height=500",
          email: result.user.providerData[1].email);
      AppData.user = userModel;
      consoleMessage(userModel.toString());
      return userModel;
    }).catchError((e) {
      if (e is PlatformException) {
        consoleMessage(
            "Facebook Error Code: ${e.code}, Facebook Error Message: ${e.message}");
      }
      return userModel;
    });
  }
  return userModel;
}

Future<void> loginLog(String email) async {
  Firestore.instance
      .collection(Collections.UserLogins)
      .add({"email": email, "action_date": DateTime.now(), "type": "login"});
}

Future<void> logoutLog(String email) async {
  Firestore.instance
      .collection(Collections.UserLogins)
      .add({"email": email, "action_date": DateTime.now(), "type": "logout"});
}

signOut() {
  FirebaseAuth.instance.signOut().then((_) {
    consoleMessage("USER SIGN OUT SUCCESFULLY");
    AppData.user = null;
    AppData.canApprove = false;
    AppData.coordinate = null;
    AppData.documentID = "";
    AppData.homeSelectedCategory = "Mekanlar";
  });
}

redirectIfNotSignedIn(BuildContext context) {
  FirebaseAuth.instance.currentUser().then((user) {
    if (user == null) {
      redirectToRoute(context, CustomRoute.signIn);
    }
  });
}
