import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/card_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/image_uploader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static List<Asset> _assets;
  static String _imageSelectedInfo;
  static Image _avatar;

  @override
  void initState() {
    nameController.text = AppData.user["name"];
    emailController.text = AppData.user["email"];
    passwordController.text = AppData.user["password"];
    _assets = List<Asset>();
    _imageSelectedInfo = _assets.length == 0
        ? "Herhangi bir fotoğraf seçilmedi."
        : "1 adet fotoğraf seçildi.";
    _avatar = AppData.user.containsKey("avatar") && AppData.user["avatar"] != ""
        ? Image.network(
            AppData.user["avatar"],
            fit: BoxFit.cover,
            width: 86,
            height: 86,
          )
        : Image.asset(
            "assets/images/avatar.png",
            width: 86,
            height: 86,
          );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(top: 60, bottom: 10),
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
                      var temp = await pickImages(maxImages: 1);
                      setState(() {
                        _assets = temp;
                        _imageSelectedInfo = _assets.length != 0
                            ? "1 adet fotoğraf seçildi."
                            : "Herhangi bir fotoğraf seçilmedi";
                      });
                      print("Files are selected!");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(child: Text(_imageSelectedInfo)),
                ),
                Form(
                  key: _formKey,
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      //Name Surname
                      TextInputComponent(
                        nameController,
                        labelText: "Ad Soyad",
                      ),

                      //Email
                      TextInputComponent(
                        emailController,
                        labelText: "Eposta",
                        enabled: false,
                      ),

                      TextInputComponent(
                        passwordController,
                        labelText: "Şifre",
                        obscureText: true,
                      ),

                      ButtonComponent(
                        text: "Güncelle",
                        onPressed: () async {
                          var name = nameController.text.trim();
                          var email = emailController.text.trim();
                          var password = passwordController.text.trim();
                          AppData.user["name"] = name;
                          AppData.user["password"] = password;
                          var tempUrl = "";
                          if (_assets.length != 0) {
                            tempUrl = await uploadSelectedAsset(
                                _assets[0], "avatars");
                            AppData.user["avatar"] = tempUrl;
                            _assets.removeAt(0);
                          }
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Row(
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                AppColor.pink),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("İşleminiz devam ediyor"),
                                      )
                                    ],
                                  ),
                                );
                              });

                          Firestore.instance
                              .collection(Collection.Users)
                              .document(AppData.documentID)
                              .updateData(AppData.user)
                              .then((value) {
                            setState(() {
                              _avatar = Image.network(
                                AppData.user["avatar"],
                                fit: BoxFit.cover,
                                width: 86,
                                height: 86,
                              );
                              _assets = List<Asset>();
                            });
                          }).whenComplete(() => Navigator.of(context).pop());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Not: Eposta adresi güncellenmemektedir.",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
