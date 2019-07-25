import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/screens/forget_password_screen.dart';
import 'package:cocukla/screens/sign_up_screen.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/device_location.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController, passwordController;
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null && user.email != null) {
        getLocation().then((position) => AppData.position = position);
        getAddrInfo().then((result) => AppData.placemarks = result);
        Navigator.of(context).pushNamed(CustomRoute.home);
      }
    });

    getLocation().then((position) => AppData.position = position);
    getAddrInfo().then((result) => AppData.placemarks = result);

    emailController = TextEditingController();
    passwordController = TextEditingController();



    super.initState();
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
                      onPressed: () async {
                        _email = emailController.text.trim();
                        _password = passwordController.text.trim();

                        if (_email.isNotEmpty && _password.isNotEmpty) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((user) {
                            AppData.user = user;
                            loginLog(_email);
                            Navigator.pushNamed(context, CustomRoute.home);
                          }).catchError((e) {
                            if (e is PlatformException) {
                              print(e);
                              if (e.code == "ERROR_USER_NOT_FOUND") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Kullanıcı bulunamadı. Lütfen üye olunuz."),
                                  action: SnackBarAction(
                                    onPressed: () => Navigator.pushNamed(
                                        context, CustomRoute.signUp),
                                    label: "Üye ol",
                                  ),
                                ));
                              }
                              if (e.code == "ERROR_WRONG_PASSWORD") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Kullanıcı adı yada şifre yanlış!"),
                                ));
                              }
                              if (e.code == "ERROR_INVALID_EMAIL") {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Girdiğiniz eposta doğru değil!"),
                                ));
                              }
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
                  Container(
                    alignment: Alignment.topRight,
                    child: ButtonComponent(
                      text: "Şifremi unuttum?",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPasswordScreen()));
                      },
                      color: Colors.transparent,
                      textColor: AppColor.text_color,
                    ),
                  ),

                  //Facebook
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ButtonComponent(
                      text: "Facebook ile giriş yap",
                      color: AppColor.facebook,
                      textColor: AppColor.white,
                      onPressed: () {
                        signInWithFacebook().then((user){
                          if(user != null){
                            Navigator.pushNamed(context, CustomRoute.home);
                          }
                        }).catchError((e){
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Facebook ile giriş yapamadınız"),));
                        });
                      },
                    ),
                  ),

                  //Google
                  ButtonComponent(
                      text: "Google ile giriş yap",
                      color: AppColor.google,
                      textColor: AppColor.white,
                      onPressed: () async {
                        signInWithGoogle().then((user) {
                          AppData.user = user;
                          Navigator.of(context).pushNamed(CustomRoute.home);
                        }).catchError((e) {
                          if (e is PlatformException) {
                            print(e.code);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Google ile giriş yapamadınız."),
                            ));
                          }
                        });
                      }),

                  //Sign Up
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.topRight,
                    child: ButtonComponent(
                      text: "Hesabınız yoksa. Üye Olun!",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      color: Colors.white,
                      textColor: AppColor.text_color,
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
