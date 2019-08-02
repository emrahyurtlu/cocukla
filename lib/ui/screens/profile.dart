import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/business/user_service.dart';
import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/card_component.dart';
import 'package:cocukla/ui/components/dropdown_component.dart';
import 'package:cocukla/ui/components/text_input_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/address_statics.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/city_info.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:cocukla/utilities/image_uploaderv2.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static Image _avatar;
  static String _name;
  static String _password;
  static String _tempUrl;
  FirebaseUser user;

  static String _citySelected = "";
  static String _districtSelected = "";
  static List<String> _cities;
  static List<String> _districts;

  UserService userService;

  static File _temp;

  @override
  void initState() {
    consoleMessage("PROFILE SCREEN: ${AppData.user.toString()}");
    _nameController.text = _name = AppData.user.name;
    emailController.text = AppData.user.email;
    _tempUrl = AppData.user.image;
    if (_tempUrl.isNotEmpty) {
      _avatar = Image.network(
        _tempUrl,
        width: 86,
      );
    } else {
      _avatar = Image.asset(
        "assets/images/user.png",
        width: 86,
      );
    }

//    _assets = null;

    _citySelected =
        AppData.user.city ?? AppData.placemarks[0].administrativeArea;
    _districtSelected =
        AppData.user.district ?? AppData.placemarks[0].subAdministrativeArea;
    _cities = AddressStatics.getCities();
    _districts = getDistrictList(_citySelected ?? "Ankara");
    userService = UserService();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    redirectIfNotSignedIn(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Profilim", style: AppStyle.AppBarTextStyle),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: SafeArea(
          child: CardComponent(
            child: ListView(
              children: <Widget>[
                //Image Upload
                Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 20),
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: CircleAvatar(
                            child: ClipOval(child: _avatar),
                            radius: 50,
                            backgroundColor: AppColor.light_gray,
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: AppColor.white,
                        ),
                      ],
                    ),
                    onTap: () async {
                      var image = await getImage();
                      if (image != null) {
                        setState(() {
                          _temp = image;
                          _avatar = Image.file(
                            _temp,
                            fit: BoxFit.cover,
                            width: 86,
                            height: 86,
                          );
                        });
                        consoleMessage("Files are selected!");
                      }
                    },
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
                        emailController,
                        labelText: "Eposta",
                        enabled: false,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 10),
                        child: Text(
                          "Not: Eposta adresi güncellenmemektedir.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),

                      TextInputComponent(
                        _passwordController,
                        labelText: "Şifre",
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

                      ButtonComponent(
                        text: "Güncelle",
                        onPressed: () async {
                          _name = _nameController.text.trim();
                          _password = _passwordController.text.trim();
                          _citySelected = _citySelected.trim();
                          _districtSelected = _districtSelected.trim();

                          processing(context);
                          //Upload image
                          if (_temp != null) {
                            var url = await uploadFile(_temp);
                            setState(() {
                              _tempUrl = url;
                            });
                          }

                          if (_password.isNotEmpty) {
                            if (_password.length > 5) {
                              var fbUser =
                                  await FirebaseAuth.instance.currentUser();
                              if (fbUser != null)
                                await fbUser.updatePassword(_password);
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "Şifreniz en az 6 karakterden oluşmalıdır."),
                              ));
                            }
                          }

                          var userModel = AppData.user;
                          userModel.name = _name;
                          userModel.city = _citySelected;
                          userModel.district = _districtSelected;
                          userModel.image = _tempUrl;
                          userModel.updateDate = Timestamp.now();

                          //Users koleksiyonunu güncelle
                          await userService.update(userModel);
                          AppData.user = userModel;
                          Navigator.pop(context);
                        },
                      ),
                      /*Divider(
                        indent: 20,
                        endIndent: 20,
                      ),

                      ButtonComponent(
                        text: "Hesabımı sil",
                        onPressed: () {
                          showDialog(
                              context: context,
                              child: Center(
                                child: Card(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text(
                                              'Hesabınızı silmek istediğinize emin misiniz?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        ButtonTheme.bar(
                                          height: 30,
                                          child: ButtonBar(
                                            children: <Widget>[
                                              FlatButton(
                                                child: const Chip(
                                                  label: Text(
                                                    'Evet',
                                                    style: TextStyle(
                                                        color: AppColor.white),
                                                  ),
                                                  backgroundColor:
                                                      AppColor.pink,
                                                ),
                                                onPressed: () {
                                                  consoleMessage(
                                                      "Hesap silindi");
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: const Chip(
                                                  label: Text('İptal'),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ));
                        },
                        color: Colors.black,
                      )*/
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
