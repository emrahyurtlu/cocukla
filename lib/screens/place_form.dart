import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/card_component.dart';
import 'package:cocukla/components/dropdown_component.dart';
import 'package:cocukla/components/header_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/ui/font_family.dart';
import 'package:cocukla/utilities/address_statics.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/city_info.dart';
import 'package:cocukla/utilities/image_uploader.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PlaceForm extends StatefulWidget {
  PlaceModel data;

  PlaceForm([this.data]);

  @override
  _PlaceFormState createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static TextEditingController _nameController = TextEditingController();
  static TextEditingController _digestController = TextEditingController();
  static TextEditingController _phoneController = TextEditingController();
  static TextEditingController _faxController = TextEditingController();
  static TextEditingController _addressController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _coordinateController =
      TextEditingController(text: AppData.coordinate);
  static String _categorySelected;
  static String _citySelected = "";
  static String _districtSelected = "";
  static DateTime _insertDate;
  static DateTime _updateDate;
  static List<String> _cities;
  static List<String> _districts;
  static List<Asset> _assets;
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

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      print("-----------------------------------------");
      print("PLACE ADD/UPDATE FORM");
      print(user.toString());
      print("-----------------------------------------");
      if (user != null && user.email != null) {
        AppData.user = user;
        setState(() {
          this.user = user;
        });
      } else {
        Navigator.of(context).pushNamed(CustomRoute.signIn);
      }
    });
    _insertDate = widget.data.insertDate != null
        ? widget.data.insertDate
        : DateTime.now();
    _updateDate = DateTime.now();
    _nameController.text = widget.data.name;
    _digestController.text = widget.data.digest;
    _phoneController.text = widget.data.phone;
    _faxController.text = widget.data.fax;
    _emailController.text = widget.data.email;
    _addressController.text = widget.data.address;
    _coordinateController.text = widget.data.location.isNotEmpty
        ? widget.data.location
        : AppData.coordinate;
    _categorySelected = widget.data.category ?? "";
    _citySelected = widget.data.city ?? "";
    _districtSelected = widget.data.district ?? "";
    _citySelected = AppData.placemarks[0].administrativeArea;
    _districtSelected = AppData.placemarks[0].subAdministrativeArea;
    _cities = AddressStatics.getCities();
    _assets = List<Asset>();
    /*****************************************************/
    for (var element in widget.data.properties) {
      if (element["content"] == "Çocuk menüsü") _cocukMenusu = true;

      if (element["content"] == "Çocuk oyun alanı") _oyunAlani = true;

      if (element["content"] == "Oyun ablası") _oyunAblasi = true;

      if (element["content"] == "Çocuk atölyesi") _atolye = true;

      if (element["content"] == "Çocuk tuvaleti") _tuvalet = true;

      if (element["content"] == "Çocuk masa ve sandalyesi")
        _masaSandalye = true;

      if (element["content"] == "Bebek bakım odası") _bebekBakimOdasi = true;

      if (element["content"] == "Özel gün organizasyonu") _organizasyon = true;

      if (element["content"] == "Randevu ile gidilir") _randevu = true;

      if (element["content"] == "Alkol tüketilir") _alkol = true;

      if (element["content"] == "Toplantı organizasyonu")
        _yemekliToplanti = true;
    }
    /*****************************************************/
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setDistricts(cityName: _citySelected);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Yeni Ekle",
              style: TextStyle(
                  color: AppColor.text_color,
                  fontFamily: FontFamily.MontserratRegular)),
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
                        options: [
                          "Mekanlar",
                          "Aktiviteler",
                          "Sağlık",
                          "Alışveriş"
                        ],
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
                          var temp = await pickImages();
                          setState(() {
                            _assets = temp;
                            _imageSelectedInfo =
                                "${_assets.length} adet fotoğraf seçildi.";
                          });
                          print("Files are selected!");
                        },
                      ),
                      Text(_imageSelectedInfo),

                      HeaderComponent(
                        "Adres Bilgiler",
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
                      TextInputComponent(
                        _faxController,
                        labelText: "Fax",
                        inputType: TextInputType.phone,
                      ),
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
                          List<String> images = [];
                          var properties = List<Map<String, dynamic>>();
                          widget.data.name = _nameController.text.trim();
                          widget.data.digest = _digestController.text.trim();
                          widget.data.category = _categorySelected.trim();
                          widget.data.location =
                              _coordinateController.text.trim();
                          widget.data.city = _citySelected.trim();
                          widget.data.district = _districtSelected.trim();
                          widget.data.phone = _phoneController.text.trim();
                          widget.data.fax = _faxController.text.trim();
                          widget.data.email = _emailController.text.trim();
                          widget.data.owner = AppData.user.email;
                          widget.data.insertDate = _insertDate;
                          widget.data.updateDate = _updateDate;

                          //Validation
                          if (widget.data.name.isNotEmpty &&
                              widget.data.category.isNotEmpty &&
                              (widget.data.images.length > 0 ||
                                  (_assets != null && _assets.length > 0)) &&
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
                              widget.data.phone.isNotEmpty &&
                              widget.data.email.isNotEmpty &&
                              widget.data.city.isNotEmpty &&
                              widget.data.district.isNotEmpty &&
                              widget.data.location.isNotEmpty) {
                            if (_cocukMenusu)
                              properties.add({
                                "content": "Çocuk menüsü",
                                "icon_name": "restaurant_menu"
                              });

                            if (_oyunAlani)
                              properties.add({
                                "content": "Çocuk oyun alanı",
                                "icon_name": "category"
                              });

                            if (_oyunAblasi)
                              properties.add({
                                "content": "Çocuk oyun ablası",
                                "icon_name": "remove_red_eye"
                              });

                            if (_atolye)
                              properties.add({
                                "content": "Çocuk atölyesi",
                                "icon_name": "color_lens"
                              });

                            if (_tuvalet)
                              properties.add({
                                "content": "Çocuk tuvaleti",
                                "icon_name": "wc"
                              });

                            if (_masaSandalye)
                              properties.add({
                                "content": "Çocuk masa ve sandalyesi",
                                "icon_name": "event_seat"
                              });

                            if (_bebekBakimOdasi)
                              properties.add({
                                "content": "Bebek bakım odası",
                                "icon_name": "child_care"
                              });

                            if (_organizasyon)
                              properties.add({
                                "content": "Özel gün organizasyonu",
                                "icon_name": "cake"
                              });

                            if (_organizasyon)
                              properties.add({
                                "content": "Randevu ile gidilir",
                                "icon_name": "calendar_today"
                              });

                            if (_alkol)
                              properties.add({
                                "content": "Alkol tüketilir",
                                "icon_name": "local_bar"
                              });

                            if (_yemekliToplanti)
                              properties.add({
                                "content": "Toplantı organizasyonu",
                                "icon_name": "work"
                              });

                            widget.data.properties = properties;

                            widget.data.rating = 0;
                            widget.data.isActive = false;
                            widget.data.isApproved = false;
                            widget.data.isFav = false;
                            widget.data.comments =
                                (widget.data.comments != null &&
                                        widget.data.comments.length > 0)
                                    ? widget.data.comments
                                    : [];

                            List<String> urlList;
                            if (_assets.length > 0)
                              urlList =
                                  await uploadSelectedAssets(_assets, "places");
                            if (urlList != null) {
                              print("PHOTOS: " + urlList.toString());
                              widget.data.images = urlList;

                              /**********************************************/
                              if (widget.data.documentID == null || widget.data.documentID.isEmpty) {
                                //Insert Code
                                _insert(context, widget.data.toJson());
                              } else {
                                //Update Code
                                _update(context, widget.data.toJson());
                              }

                              /**********************************************/

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
                                        "Tamam",
                                        style: TextStyle(color: AppColor.white),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ]).show();
                            }

                            //Validation
                            print(widget.data.toString());
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

_update(BuildContext context, Map map) {
  print("UPDATE SECTION: ");
  print(map);

  Firestore.instance.document(map["documentID"]).setData(map).then((result) {
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
  print("INSERT SECTION: ");
  print(map);

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
