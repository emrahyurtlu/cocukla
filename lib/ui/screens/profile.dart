import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/card_component.dart';
import 'package:cocukla/ui/components/text_input_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/image_uploader.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _nameController = TextEditingController();
  final emailController = TextEditingController();
  final _passwordController = TextEditingController();
  static List<Asset> _assets;
  static Image _avatar;
  static String _name;
  static String _password;
  static String _tempUrl;
  FirebaseUser user;

  @override
  void initState() {
    _nameController.text = _name = AppData.user.name;
    emailController.text = AppData.user.email;

    if (AppData.user.image != null) {
      _avatar = Image.network(
        AppData.user.image,
        width: 86,
      );
    } else {
      _avatar = Image.asset(
        "assets/images/user.png",
        width: 86,
      );
    }

    _assets = null;

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
                      var temp = await pickImages(maxImages: 1);
                      var bytes = await temp[0].requestOriginal();
                      setState(() {
                        _assets = temp;
                        _avatar = Image.memory(
                          bytes.buffer.asUint8List(),
                          width: 86,
                        );
                      });
                      print("Files are selected!");
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

                      TextInputComponent(
                        _passwordController,
                        labelText: "Şifre",
                        obscureText: true,
                      ),

                      ButtonComponent(
                        text: "Güncelle",
                        onPressed: () async {
                          setState(() {
                            _name = _nameController.text.trim();
                            _password = _passwordController.text.trim();
                          });
                          var dismiss = false;
                          processing(context, dismiss: dismiss);

                          if (_assets != null && _assets.length != 0) {
                            var res = await uploadSelectedAsset(
                                _assets[0], "avatars");
                            _assets.clear();
                            setState(() {
                              _tempUrl = res;
                            });
                          }
                          var info = UserUpdateInfo();
                          info.displayName = _name;
                          info.photoUrl = _tempUrl;

                          user.updateProfile(info).then((_) {
                            dismiss = true;
                            user.reload();
                          }).catchError(
                              (e) => print("PROFILE UPDATE ERROR: " + e));
                          user.reload().then((_) => dismiss = true);
                          dismiss = true;
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
