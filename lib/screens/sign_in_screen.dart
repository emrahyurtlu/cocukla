import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/screens/forget_password_screen.dart';
import 'package:cocukla/screens/sign_up_screen.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController, passwordController;
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    //_googleSignIn = GoogleSignIn();
    if (AppData.user != null) {
      Navigator.of(context).pushNamed("/home");
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*WidgetsBinding.instance.addPostFrameCallback((callBack) {
      if (FirebaseAuth.instance.currentUser() != null)
        Navigator.of(context).pushNamed("/home");
    });*/

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: AppColor.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 40),
              child: Image.asset(
                "assets/images/cocukla_logo.png",
                width: 88,
                height: 113,
              ),
            ),
            Form(
              key: _formKey,
              child: Center(
                  child: Column(
                children: <Widget>[
                  //Email TextField
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.light_gray,
                            ),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                //errorText: "Bu alan boş olamaz",
                                labelStyle:
                                    TextStyle(color: AppColor.text_color),
                                labelText: 'Eposta',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Password TextField
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.light_gray,
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                //errorText: "Bu alan boş olamaz",
                                labelStyle:
                                    TextStyle(color: AppColor.text_color),
                                labelText: 'Şifre',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //LoginButton
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 50,
                          child: FlatButton(
                            color: AppColor.pink,
                            textColor: AppColor.white,
                            onPressed: () {
                              _email = emailController.text.trim();
                              _password = passwordController.text.trim();

                              if (_email.isNotEmpty && _password.isNotEmpty) {
                                Firestore.instance
                                    .collection(Collection.Users)
                                    .where("email", isEqualTo: _email)
                                    .where("password", isEqualTo: _password)
                                    .snapshots()
                                    .first
                                    .then((user) {
                                  if (user.documents.length > 0) {
                                    AppData.user = user.documents[0].data;
                                    Navigator.of(context).pushNamed("/home");
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                                        content: Text(
                                            "Eposta veya şifre bilgisi yanlış!")));
                                  }
                                });
                              } else {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Eposta veya şifre alanı boş olamaz!"),
                                ));
                              }
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0)),
                            child: Text(
                              "Giriş Yap",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Forget Password
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 50,
                          alignment: Alignment.topRight,
                          child: FlatButton(
                            textColor: AppColor.text_color,
                            onPressed: () {
                              /*Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                  Text("Şifremi unuttum ekranına gider!"),
                                ))*/
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen()),
                              );
                            },
                            child: Text(
                              "Şifremi unuttum?",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 300,
                    height: 30,
                  ),

                  //Facebook
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 50,
                          child: FlatButton(
                            color: AppColor.facebook,
                            textColor: AppColor.white,
                            onPressed: () {
                              loginWithFacebook();
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0)),
                            child: Text(
                              "Facebook ile giriş yap",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Google
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 50,
                          child: FlatButton(
                            color: AppColor.google,
                            textColor: AppColor.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0)),
                            child: Text(
                              "Google ile giriş yap",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 14),
                            ),
                            onPressed: () {
                              loginWithGoogle().then((FirebaseUser result) {
                                UserUpdateInfo info = UserUpdateInfo();
                                info.photoUrl = result.photoUrl;
                                info.displayName = info.displayName;

                                result.updateProfile(info);
                                Navigator.of(context).pushNamed("/home");
                              }).catchError((e) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Google ile giriş yapamadınız."),
                                ));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Sign Up
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 60,
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            textColor: AppColor.text_color,
                            onPressed: () {
                              /*Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Hesabınız yoksa. Üye Olun!"),
                                  ))*/
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text(
                              "Hesabınız yoksa. Üye Olun!",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
