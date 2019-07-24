import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/ui/font_family.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Üye Olun",
            style: TextStyle(
                color: AppColor.text_color,
                fontFamily: FontFamily.MontserratRegular)),
        backgroundColor: AppColor.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.text_color),
      ),
      body: SafeArea(
        child: Container(
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
                    //Name Surname
                    TextInputComponent(
                      _nameController,
                      labelText: "Ad Soyad",
                    ),

                    //Email
                    TextInputComponent(
                      _emailController,
                      labelText: "Eposta",
                      hintText: "you@example.com",
                      inputType: TextInputType.emailAddress,
                    ),

                    //Password
                    TextInputComponent(
                      _passwordController,
                      labelText: "Şifre",
                      hintText: "***",
                      inputType: TextInputType.text,
                      obscureText: true,
                    ),

                    //Submit btn
                    ButtonComponent(
                      text: "Üye Ol",
                      onPressed: () {
                        var name = _nameController.text.trim();
                        var email = _emailController.text.trim();
                        var password = _passwordController.text.trim();
                        if (name.isNotEmpty &&
                            email.isNotEmpty &&
                            (password.isNotEmpty && password.length > 5)) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((FirebaseUser user) {
                            UserUpdateInfo updateInfo;
                            updateInfo.displayName = name;

                            AppData.user = user;

                            user.updateProfile(updateInfo).then((val) {
                              Navigator.pushNamed(context, "/home");
                            }).catchError(
                                (e) => print("USER DATA UPDATE ERROR: " + e));
                          }).catchError((e) {
                            if (e is PlatformException) {
                              if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content:
                                        Text("Girilen eposta kullanımdadır.")));
                              }
                            }
                          });
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  "Alanlar boş olamaz. Şifre en az 6 karakterden oluşmalıdır.")));
                        }
                      },
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
