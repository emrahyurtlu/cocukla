import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/text_input_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifremi Unuttum", style: AppStyle.AppBarTextStyle),
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
                    TextInputComponent(_emailController,labelText: "Eposta", hintText: "you@example.com", inputType: TextInputType.emailAddress,),
                    ButtonComponent(text: "Şifremi Hatırlat", onPressed: () {
                      var email = _emailController.text.trim();
                      if(email != null){
                        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((result){
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Eposta adresinize şifre hatırlatma postası gönderildi."),));
                        }).catchError((e) {
                          print(e);
                        });
                      }
                    },),
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
