import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatelessWidget {
  final _formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Profile() {
    nameController.text = "John Doe";
    emailController.text = "john@gmail.com";
    passwordController.text = "12***33";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profilim",
              style: TextStyle(
                  color: AppColor.text_color, fontFamily: "MontserratRegular")),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                border: Border.all(color: Colors.white),
                color: AppColor.white),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Image.asset(
                          "assets/images/avatar.png",
                          width: 86,
                          height: 86,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: AppColor.white,
                      )
                    ],
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
                                  controller: nameController,
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
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: new InputDecoration(
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
                                  controller: passwordController,
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
                                      print("Güncellendi!")
                                      /*Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text("Uygulamaya üye oldunuz!"),
                                      ))*/
                                      //Navigator.pop(context)
                                    },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0)),
                                child: Text(
                                  "Güncelle",
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
      ),
    );
  }
}
