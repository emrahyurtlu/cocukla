import 'package:cocukla/screens/forget_password_screen.dart';
import 'package:cocukla/screens/sign_up_screen.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey();
    final myController = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the Widget is disposed
      myController.dispose();
      //super.dispose();
    }

    return Scaffold(
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
                              controller: null,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
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
                              controller: null,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
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
                            onPressed: () => {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Uygulamaya giriş yaptınız!"),
                                  ))
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
                            onPressed: () => {
                                  /*Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                  Text("Şifremi unuttum ekranına gider!"),
                                ))*/
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordScreen()),
                                  )
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
                            onPressed: () => {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text("Facebook ile giriş yaptınız!"),
                                  ))
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
                            onPressed: () => {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Google ile giriş yaptınız!"),
                                  ))
                                },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0)),
                            child: Text(
                              "Google ile giriş yap",
                              textAlign: TextAlign.center,
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
                    height: 60,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 60,
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            textColor: AppColor.text_color,
                            onPressed: () => {
                                  /*Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Hesabınız yoksa. Üye Olun!"),
                                  ))*/
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()),
                                  )
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
