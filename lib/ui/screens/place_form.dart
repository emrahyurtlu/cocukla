import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/card_component.dart';
import 'package:cocukla/ui/components/conditional_component.dart';
import 'package:cocukla/ui/components/dropdown_component.dart';
import 'package:cocukla/ui/components/header_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/text_input_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/address_statics.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/city_info.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:cocukla/utilities/image_uploader.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'my_places.dart';

class PlaceForm extends StatefulWidget {
  final Map<String, dynamic> data;
  final String documentID;

  PlaceForm({this.data, this.documentID = "INITIAL DOCUMENT"});

  @override
  _PlaceFormState createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  String approveBtnText = "Onayla";
  String appBarTitle = "Yeni Ekle";
  bool insertScreen = true;
  PlaceModel model;
  DocumentSnapshot document;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static TextEditingController _nameController = TextEditingController();
  static TextEditingController _digestController = TextEditingController();
  static TextEditingController _phoneController = TextEditingController();
//  static TextEditingController _faxController = TextEditingController();
  static TextEditingController _addressController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _coordinateController =
      TextEditingController(text: AppData.coordinate);
  static String _categorySelected;
  static String _citySelected = "";
  static String _districtSelected = "";
  static List<String> _cities;
  static List<String> _districts;
  static List<String> _categories = [
    "Mekanlar",
    "Aktiviteler",
    "Sağlık",
    "Alışveriş"
  ];

//  static List<Asset> _assets;
  static String _imageSelectedInfo = "Herhangi bir resim seçilmedi";

  //Properties
  static bool _oyunAblasi = false;
  static bool _organizasyon = false;
  static bool _cocukMenusu = false;
  static bool _bebekBakimOdasi = false;
  static bool _atolye = false;
  static bool _oyunAlani = false;
  static bool _tuvalet = false;
  static bool _masaSandalye = false;
  static bool _randevu = false;
  static bool _alkol = false;
  static bool _yemekliToplanti = false;
  FirebaseUser user;

  /*******************************************/
  List<File> files = List<File>();
  List<String> fileUrls = List<String>();

  /*******************************************/

  @override
  void initState() {
    consoleLog("PLACE ADD/UPDATE SCREEN");
    if (widget.data != null) appBarTitle = "Güncelle";
    if (widget.data != null) insertScreen = false;
    model = widget.data != null
        ? PlaceModel.from(data: widget.data, documentID: widget.documentID)
        : PlaceModel();

    model.owner = model.owner ??= AppData.user.email;
    model.rating = model.rating ??= "0";
    _nameController.text = model.name ??= "";
    _digestController.text = model.digest ??= "";
    _phoneController.text = model.phone ??= "";
//    _faxController.text = model.fax ??= "";
    _emailController.text = model.email ??= "";
    _addressController.text = model.address ??= "";
    _coordinateController.text = model.location ??= AppData.coordinate;
    _categorySelected = model.category ?? _categories[0];
    _citySelected = model.city ??= AppData.placemarks[0].administrativeArea;
    _districtSelected =
        model.district ??= AppData.placemarks[0].subAdministrativeArea;
    _cities = AddressStatics.getCities();
//    _assets = List<Asset>();
    /*****************************************************/
    if (model.properties != null) {
      for (var element in model.properties) {
        if (element["content"] == "Çocuk menüsü") _cocukMenusu = true;

        if (element["content"] == "Çocuk oyun alanı") _oyunAlani = true;

        if (element["content"] == "Oyun ablası") _oyunAblasi = true;

        if (element["content"] == "Çocuk atölyesi") _atolye = true;

        if (element["content"] == "Çocuk tuvaleti") _tuvalet = true;

        if (element["content"] == "Çocuk masa ve sandalyesi")
          _masaSandalye = true;

        if (element["content"] == "Bebek bakım odası") _bebekBakimOdasi = true;

        if (element["content"] == "Özel gün organizasyonu")
          _organizasyon = true;

        if (element["content"] == "Randevu ile gidilir") _randevu = true;

        if (element["content"] == "Alkol tüketilir") _alkol = true;

        if (element["content"] == "Toplantı organizasyonu")
          _yemekliToplanti = true;
      }
    }
    /*****************************************************/
    if (widget.data != null)
      approveBtnText =
          widget.data["isApproved"] == true ? "Onayı iptal et" : "Onayla";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setDistricts(cityName: _citySelected);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    redirectIfNotSignedIn(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(appBarTitle, style: AppStyle.AppBarTextStyle),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: SafeArea(
          child: CardComponent(
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      HeaderComponent(
                        "Genel Bilgiler",
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      //Mekan adı giriniz
                      TextInputComponent(
                        _nameController,
                        labelText: "Mekan adı giriniz",
                      ),
                      //Digest
                      TextInputComponent(
                        _digestController,
                        labelText: "Özet",
                      ),
                      //Category
                      DropdownComponent(
                        selected: _categorySelected,
                        options: _categories,
                        hintText: "Kategori seçiniz",
                        onChanged: (String selected) {
                          setState(() {
                            _categorySelected = selected;
                          });
                        },
                      ),
                      //Select Photos
                      ButtonComponent(
                        text: "Fotoğraf seçiniz",
                        onPressed: () async {
                          var temp = await getImage();
                          consoleLog(temp.path);
                          if (temp != null)
                            setState(() {
                              files.add(temp);
                              _imageSelectedInfo =
                                  "${files.length} adet fotoğraf seçildi.";
                            });
                          print("Files are selected!");
                        },
                      ),
                      Text(_imageSelectedInfo),
                      HeaderComponent(
                        "Adres Bilgiler",
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      TextInputComponent(
                        _coordinateController,
                        labelText: "Koordinat(Enlem,Boylam)",
                        inputType: TextInputType.text,
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
                      TextInputComponent(
                        _phoneController,
                        labelText: "Telefon",
                        inputType: TextInputType.phone,
                      ),
                      /*TextInputComponent(
                        _faxController,
                        labelText: "Fax",
                        inputType: TextInputType.phone,
                      ),*/
                      TextInputComponent(
                        _emailController,
                        labelText: "Eposta",
                        inputType: TextInputType.emailAddress,
                      ),
                      TextInputComponent(
                        _addressController,
                        labelText: "Adres",
                      ),
                      HeaderComponent(
                        "Özellikler",
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      //Çocuk menüsü
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "restaurant_menu",
                          content: "Çocuk menüsü",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _cocukMenusu,
                        onChanged: (state) {
                          setState(() {
                            _cocukMenusu = state;
                          });
                        },
                      ),
                      //Çocuk oyun alanı
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "category",
                          content: "Çocuk oyun alanı",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _oyunAlani,
                        onChanged: (state) {
                          setState(() {
                            _oyunAlani = state;
                          });
                        },
                      ),
                      //Oyun ablası
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "remove_red_eye",
                          content: "Oyun ablası",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _oyunAblasi,
                        onChanged: (state) {
                          setState(() {
                            _oyunAblasi = state;
                          });
                        },
                      ),
                      //Çocuk atölyesi
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "color_lens",
                          content: "Çocuk atölyesi",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _atolye,
                        onChanged: (state) {
                          setState(() {
                            _atolye = state;
                          });
                        },
                      ),
                      //Çocuk tuvaleti
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "wc",
                          content: "Çocuk tuvaleti",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _tuvalet,
                        onChanged: (state) {
                          setState(() {
                            _tuvalet = state;
                          });
                        },
                      ),
                      //Çocuk masa ve sandalyesi
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "event_seat",
                          content: "Çocuk masa ve sandalyesi",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _masaSandalye,
                        onChanged: (state) {
                          setState(() {
                            _masaSandalye = state;
                          });
                        },
                      ),
                      //Bebek bakım odası
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "child_care",
                          content: "Bebek bakım odası",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _bebekBakimOdasi,
                        onChanged: (state) {
                          setState(() {
                            _bebekBakimOdasi = state;
                          });
                        },
                      ),
                      //Özel gün organizasyonu
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "cake",
                          content: "Özel gün organizasyonu",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _organizasyon,
                        onChanged: (state) {
                          setState(() {
                            _organizasyon = state;
                          });
                        },
                      ),
                      //Randevu ile gidilir
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "calendar_today",
                          content: "Randevu ile gidilir",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _randevu,
                        onChanged: (state) {
                          setState(() {
                            _randevu = state;
                          });
                        },
                      ),
                      //Alkol tüketilir
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "local_bar",
                          content: "Alkol tüketilir",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _alkol,
                        onChanged: (state) {
                          setState(() {
                            _alkol = state;
                          });
                        },
                      ),
                      //Toplantı organizasyonu
                      SwitchListTile(
                        title: PropertyComponent(
                          iconName: "work",
                          content: "Toplantı organizasyonu",
                          padding: EdgeInsets.only(left: 10),
                        ),
                        value: _yemekliToplanti,
                        onChanged: (state) {
                          setState(() {
                            _yemekliToplanti = state;
                          });
                        },
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      ButtonComponent(
                        text: "Kaydet",
                        onPressed: () async {
                          var properties = List<Map<String, dynamic>>();
                          model.name = _nameController.text.trim();
                          model.digest = _digestController.text.trim();
                          model.category = _categorySelected.trim();
                          model.location = _coordinateController.text.trim();
                          model.city = _citySelected.trim();
                          model.district = _districtSelected.trim();
                          model.phone = _phoneController.text.trim();
                          //model.fax = _faxController.text.trim();
                          model.email = _emailController.text.trim();
                          model.address = _addressController.text.trim();
                          model.insertDate = model.insertDate ??=
                              Timestamp.fromDate(DateTime.now());
                          model.updateDate = Timestamp.fromDate(DateTime.now());

                          //Validation
                          // ||
                          //                                  (_assets != null && _assets.length > 0)
                          if (model.name.isNotEmpty &&
                              model.category.isNotEmpty &&
                              ((model.images != null ||
                                  (files != null && files.length > 0))) &&
                              (_cocukMenusu ||
                                  _oyunAblasi ||
                                  _oyunAlani ||
                                  _tuvalet ||
                                  _yemekliToplanti ||
                                  _bebekBakimOdasi ||
                                  _randevu ||
                                  _organizasyon ||
                                  _atolye ||
                                  _masaSandalye) &&
                              model.phone.isNotEmpty &&
                              model.email.isNotEmpty &&
                              model.city.isNotEmpty &&
                              model.district.isNotEmpty &&
                              model.location.isNotEmpty) {
                            processing(context);

                            if (_cocukMenusu)
                              properties.add({
                                "content": "Çocuk menüsü",
                                "iconName": "restaurant_menu"
                              });

                            if (_oyunAlani)
                              properties.add({
                                "content": "Çocuk oyun alanı",
                                "iconName": "category"
                              });

                            if (_oyunAblasi)
                              properties.add({
                                "content": "Çocuk oyun ablası",
                                "iconName": "remove_red_eye"
                              });

                            if (_atolye)
                              properties.add({
                                "content": "Çocuk atölyesi",
                                "iconName": "color_lens"
                              });

                            if (_tuvalet)
                              properties.add({
                                "content": "Çocuk tuvaleti",
                                "iconName": "wc"
                              });

                            if (_masaSandalye)
                              properties.add({
                                "content": "Çocuk masa ve sandalyesi",
                                "iconName": "event_seat"
                              });

                            if (_bebekBakimOdasi)
                              properties.add({
                                "content": "Bebek bakım odası",
                                "iconName": "child_care"
                              });

                            if (_organizasyon)
                              properties.add({
                                "content": "Özel gün organizasyonu",
                                "iconName": "cake"
                              });

                            if (_organizasyon)
                              properties.add({
                                "content": "Randevu ile gidilir",
                                "iconName": "calendar_today"
                              });

                            if (_alkol)
                              properties.add({
                                "content": "Alkol tüketilir",
                                "iconName": "local_bar"
                              });

                            if (_yemekliToplanti)
                              properties.add({
                                "content": "Toplantı organizasyonu",
                                "iconName": "work"
                              });

                            if (_randevu)
                              properties.add({
                                "content": "Randevu ile gidilir",
                                "iconName": "calendar_today"
                              });

                            model.properties = properties;
                            model.comments = model.comments ??= [];

                            if (files.length > 0) {
                              for (var image in files) {
                                if (image != null) {
                                  var tempUrl =
                                      await uploadFile(image, "places");
                                  if (tempUrl.isNotEmpty)
                                    setState(() {
                                      fileUrls.add(tempUrl);
                                    });
                                }
                              }
                            }

                            if (fileUrls.length > 0) {
                              print("PHOTOS: " + fileUrls.toString());
                              model.images = fileUrls;
                            }

                            /**********************************************/
                            var json = model.toJson();

                            if (widget.data == null) {
                              //Insert Code
                              _insert(context, json);
                            } else {
                              //Update Code
                              _update(context, json, widget.documentID);
                            }

                            /**********************************************/

                            //Validation
                            print(model.toString());
                            Navigator.pop(context);
                          } else {
                            Alert(
                                context: context,
                                title: "Hata",
                                desc:
                                    "Ad, telefon, eposta, lokasyon alanı zorunludur. En az bir tane fotoğraf seçilmelidir. En az bir özellik işaretlenmelidir ",
                                type: AlertType.error,
                                buttons: <DialogButton>[
                                  DialogButton(
                                    child: Text(
                                      "Evet",
                                      style: TextStyle(color: AppColor.white),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ]).show();
                          }
                        },
                      ),

                      ConditionalComponent(
                        condition: AppData.user.isAuthorized && insertScreen,
                        child: Column(
                          children: <Widget>[
                            Divider(
                              indent: 20,
                              endIndent: 20,
                            ),
                            ButtonComponent(
                              text: approveBtnText,
                              onPressed: () {
                                Firestore.instance
                                    .collection(Collections.Places)
                                    .document(widget.documentID)
                                    .updateData({
                                  "isApproved":
                                      widget.data["isApproved"] == true
                                          ? false
                                          : true
                                }).then((_) {
                                  print("${widget.documentID} is approved!");
                                  setState(() {
                                    approveBtnText =
                                        widget.data["isApproved"] == true
                                            ? "Onayı iptal et"
                                            : "Onayla";
                                  });
                                });
                              },
                            )
                          ],
                        ),
                      ),

                      ConditionalComponent(
                        condition: widget.data != null,
                        child: Column(
                          children: <Widget>[
                            Divider(
                              indent: 20,
                              endIndent: 20,
                            ),
                            //Delete Record
                            ButtonComponent(
                              onPressed: () {
                                Alert(
                                    context: context,
                                    title: "Dikkat",
                                    desc:
                                        "Bu kaydı silmek istediğinize emin misiniz?",
                                    type: AlertType.warning,
                                    buttons: <DialogButton>[
                                      DialogButton(
                                        child: Text(
                                          "Hayır",
                                          style:
                                              TextStyle(color: AppColor.white),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: AppColor.dark_gray,
                                      ),
                                      DialogButton(
                                        child: Text(
                                          "Evet",
                                          style:
                                              TextStyle(color: AppColor.white),
                                        ),
                                        onPressed: () {
                                          print(
                                              "DELETED DOCUMENT: ${widget.documentID}");
                                          Firestore.instance
                                              .collection(Collections.Places)
                                              .document(widget.documentID)
                                              .updateData({"isDeleted": true});
                                          Navigator.pop(context);
                                          redirectTo(context, Places());
                                        },
                                      ),
                                    ]).show();
                              },
                              text: "Kaydı sil",
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),

                      //Approve Button
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

  void setDistricts({String cityName = "Ankara"}) {
    var result = getDistrictList(_citySelected ?? "Ankara");
    setState(() {
      _districts = result;
    });
  }
}

_update(BuildContext context, Map map, String documentID) {
  print("UPDATE SECTION: $map");

  Firestore.instance
      .collection("places")
      .document(documentID)
      .setData(map)
      .then((result) {
    Alert(
        context: context,
        title: "Başarılı",
        desc: "İşlem başarıyla tamamlandı.",
        type: AlertType.success,
        buttons: <DialogButton>[
          DialogButton(
            child: Text(
              "Tamam",
              style: TextStyle(color: AppColor.white),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ]).show();
  }).catchError((e) {
    print(e);
    Alert(
        context: context,
        title: "Hata",
        desc: "Kayıt eklenemedi.",
        type: AlertType.error,
        buttons: <DialogButton>[
          DialogButton(
            child: Text(
              "Tamam",
              style: TextStyle(color: AppColor.white),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ]).show();
  });
}

_insert(BuildContext context, Map map) {
  print("INSERT SECTION: $map");

  Firestore.instance.collection("places").add(map).then((result) {
    if (result != null)
      Alert(
          context: context,
          title: "Başarılı",
          desc: "İşlem başarıyla tamamlandı.",
          type: AlertType.success,
          buttons: <DialogButton>[
            DialogButton(
              child: Text(
                "Tamam",
                style: TextStyle(color: AppColor.white),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ]).show();
  }).catchError((e) {
    Alert(
        context: context,
        title: "Hata",
        desc: "Kayıt eklenemedi.",
        type: AlertType.error,
        buttons: <DialogButton>[
          DialogButton(
            child: Text(
              "Tamam",
              style: TextStyle(color: AppColor.white),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ]).show();
  });
}
