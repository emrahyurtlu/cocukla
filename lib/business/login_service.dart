import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<FirebaseUser> loginWithGoogle() async{
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleUser = await _googleSignIn.signIn() as GoogleSignInAccount;
  GoogleSignInAuthentication googleAuth = await googleUser.authentication as GoogleSignInAuthentication;

  AuthCredential credential = await GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential) as FirebaseUser;
  return user;
}

Future<FirebaseUser> loginWithFacebook() async{
  FacebookLogin fbLogin = FacebookLogin();

  var profile;
  fbLogin.loginWithPublishPermissions(["public_profile"]).then((FacebookLoginResult result){
    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${token}').then((http.Response res){
              profile = json.decode(res.body);
        });
        print("*******************");
        print(profile);
        print("*******************");
        break;
      case FacebookLoginStatus.cancelledByUser:

        break;
      case FacebookLoginStatus.error:

        break;
    }
  });


  return null;
}
