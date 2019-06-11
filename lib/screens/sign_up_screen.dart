import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
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
                                decoration: new InputDecoration(
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
                                    /* Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text("Uygulamaya üye oldunuz!"),
                                    ))*/
                                    Navigator.pop(context)
                                  },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              child: Text(
                                "Üye Ol",
                                textAlign: TextAlign.center,
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
      ),
    );
  }
}
