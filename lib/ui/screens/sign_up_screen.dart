import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/user_service.dart';
import 'package:cocukla/models/enums/enums.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/dropdown_component.dart';
import 'package:cocukla/ui/components/text_input_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/address_statics.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/city_info.dart';
import 'package:cocukla/utilities/route.dart';
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
  static String _citySelected = "";
  static String _districtSelected = "";
  static List<String> _cities;
  static List<String> _districts;
  UserService _userService;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _citySelected = AppData.placemarks[0].administrativeArea;
    _districtSelected = AppData.placemarks[0].subAdministrativeArea;
    _cities = AddressStatics.getCities();
    _districts = getDistrictList(_citySelected ?? "Ankara");
    _userService = UserService();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Üye Olun", style: AppStyle.AppBarTextStyle),
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

                    //City
                    DropdownComponent(
                      selected: _citySelected,
                      options: _cities,
                      hintText: "İl seçiniz",
                      onChanged: (selected) {
                        setState(() {
                          _citySelected = selected;
                          _districts = getDistrictList(selected);
                          _districtSelected = _districts[0];
                        });
                      },
                    ),

                    //District
                    DropdownComponent(
                      selected: _districtSelected,
                      options: _districts,
                      hintText: "İlçe seçiniz",
                      onChanged: (String selected) {
                        setState(() {
                          _districtSelected = selected;
                        });
                      },
                    ),

                    //Submit btn
                    ButtonComponent(
                      text: "Üye Ol",
                      onPressed: () async {
                        var name = _nameController.text.trim();
                        var email = _emailController.text.trim();
                        var password = _passwordController.text.trim();
                        var city = _citySelected.trim();
                        var district = _districtSelected.trim();
                        if (name.isNotEmpty &&
                            email.isNotEmpty &&
                            (password.isNotEmpty && password.length > 5)) {
                          //FirebaseAuth kullanıcısını oluştur
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((result) {
                            var userModel = UserModel(
                                name: name,
                                email: email,
                                image: "",
                                city: city,
                                district: district,
                                insertDate: Timestamp.now(),
                                updateDate: Timestamp.now(),
                                loginType: LoginType.Native);
                            _userService.insert(userModel);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  "Hesabınız oluşturuldu. Giriş ekranına yönlendiriliyorsunuz."),
                            ));
                            Timer(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
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
