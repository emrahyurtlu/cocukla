import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/screens/forget_password_screen.dart';
import 'package:cocukla/screens/sign_up_screen.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
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
                  TextInputComponent(
                    emailController,
                    labelText: "Eposta",
                  ),
                  //Password TextField
                  TextInputComponent(
                    passwordController,
                    labelText: "Şifre",
                    obscureText: true,
                  ),

                  //LoginButton
                  ButtonComponent(
                      text: "Giriş Yap",
                      onPressed: () {
                        _email = emailController.text.trim();
                        _password = passwordController.text.trim();

                        if (_email.isNotEmpty && _password.isNotEmpty) {
                          Firestore.instance
                              .collection(Collection.Users)
                              .where("email", isEqualTo: _email)
                              .where("password", isEqualTo: _password)
                              .snapshots()
                              .listen((user) {
                            //processing(context, dismiss: dismiss);

                            if (user.documents.length > 0) {
                              AppData.user = user.documents[0].data;
                              AppData.documentID = user.documents[0].documentID;
                              loginLog(_email);

                              Navigator.of(context).pushNamed("/home");
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Eposta veya şifre bilgisi yanlış!")));
                            }
                          });
                        } else {
                          setState(() {});
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text("Eposta veya şifre alanı boş olamaz!"),
                          ));
                        }
                      }),

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
                  ButtonComponent(
                    text: "Facebook ile giriş yap",
                    color: AppColor.facebook,
                    textColor: AppColor.white,
                    onPressed: () {
                      loginWithFacebook();
                    },
                  ),

                  //Google
                  ButtonComponent(
                    text: "Google ile giriş yap",
                    color: AppColor.google,
                    textColor: AppColor.white,
                    onPressed: () {
                      loginWithGoogle().then((FirebaseUser result) {
                        UserUpdateInfo info = UserUpdateInfo();
                        info.photoUrl = result.photoUrl;
                        info.displayName = info.displayName;

                        result.updateProfile(info);
                        Navigator.of(context).pushNamed("/home");
                      }).catchError((e) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Google ile giriş yapamadınız."),
                        ));
                      });
                    },
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
