import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

var googleSignIn = GoogleSignIn();
var _auth = FirebaseAuth.instance;

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return user;
}

FacebookLogin fbLogin = FacebookLogin();

Future<FirebaseUser> signInWithFacebook() async {
  fbLogin.loginWithPublishPermissions([]).then(
      (FacebookLoginResult result) {
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        FirebaseAuth.instance.signInWithCredential(credential).then((user) {
          if (user != null) {
            print("-----------------------------------------");
            print("FACEBOOK USER");
            print(user.toString());
            print("-----------------------------------------");
          }
        }).catchError((e) {
          if(e is PlatformException){
            print(e.code);
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  });

  return null;
}

Future<void> loginLog(String email) async {
  Firestore.instance
      .collection(Collection.UserLogins)
      .add({"email": email, "action_date": DateTime.now(), "type": "login"});
}

Future<void> logoutLog(String email) async {
  Firestore.instance
      .collection(Collection.UserLogins)
      .add({"email": email, "action_date": DateTime.now(), "type": "logout"});
}
