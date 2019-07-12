import 'package:cocukla/ui/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                color: AppColor.text_color, fontFamily: "MontserratRegular")),
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
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelStyle:
                                      TextStyle(color: AppColor.text_color),
                                  labelText: 'Ad Soyad',
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

                    //Email
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
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelStyle:
                                      TextStyle(color: AppColor.text_color),
                                  hintText: 'you@example.com',
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

                    //Password
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
                                controller: _passwordController,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelStyle:
                                      TextStyle(color: AppColor.text_color),
                                  hintText: '***',
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

                    //Submit btn
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
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              child: Text(
                                "Üye Ol",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Montserrat", fontSize: 14),
                              ),
                              onPressed: () {
                                var name = _nameController.text;
                                var email = _emailController.text;
                                var password = _passwordController.text;

                                if(name.isNotEmpty && email.isNotEmpty && (password.isNotEmpty && password.length >= 6)){
                                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((FirebaseUser user){
                                    UserUpdateInfo info = UserUpdateInfo();
                                    info.displayName = name;
                                    user.updateProfile(info).then((result){
                                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Üyelik işleminiz tamamlandı!"),));
                                    }).catchError((){
                                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Hata oluştu!"),));
                                    });

                                    Navigator.of(context).pushNamed("/sign-in");
                                  }).catchError((e){
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Veritabanına ulaşılamadı!"),));
                                    //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.toString()),));
                                  });
                                }else{
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Alanlar boş olamaz! Şifre en az 6 karakterden oluşmalıdır!"),));
                                }
                              },
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
      ),
    );
  }
}
