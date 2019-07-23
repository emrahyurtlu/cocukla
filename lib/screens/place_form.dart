import 'dart:core';

import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/card_component.dart';
import 'package:cocukla/components/dropdown_component.dart';
import 'package:cocukla/components/header_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/ui/font_family.dart';
import 'package:cocukla/utilities/address_statics.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/city_info.dart';
import 'package:cocukla/utilities/device_location.dart';
import 'package:cocukla/utilities/image_uploader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PlaceForm extends StatefulWidget {
  Map<String, dynamic> data;

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
  static TextEditingController _coordinateController = TextEditingController();
  static String _categorySelected;
  static String _citySelected = "";
  static String _districtSelected = "";
  static Position _location;
  static List<Placemark> _list;
  final _owner = AppData.user["email"];
  static int _rating = 0;
  final comments = [];
  static String insert_date;
  static String update_date;
  static List<String> _cities;
  static List<String> _districts;
  static List<Asset> _assets;
  static bool _isApproved;
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

  @override
  void initState() {
    insert_date = widget.data["insert_date"] ?? DateTime.now().toString();
    update_date = DateTime.now().toString();
    _nameController.text = widget.data["name"];
    _digestController.text = widget.data["digest"];
    _phoneController.text = widget.data["phone"];
    _faxController.text = widget.data["fax"];
    _addressController.text = widget.data["address"];
    _emailController.text = widget.data["email"];
    _coordinateController.text = widget.data["coordinate"];
    _categorySelected = widget.data["category"] ?? "";
    _citySelected = widget.data["city"] ?? "";
    _districtSelected = widget.data["district"] ?? "";
    _rating = widget.data["rating"] ?? 0;
    _isApproved = widget.data["isApproved"] ?? false;
    getLocation().then((pos) {
      _location = pos;
      if (_coordinateController.text == null)
        _coordinateController.text = pos.latitude.toString() + "," + pos.longitude.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Get Position
    /*getLocation().then((pos) {
      _location = pos;
      if (_coordinateController.text == null)
        setState(() {
          _coordinateController.text = pos.latitude.toString() + "," + pos.longitude.toString();
        });
    });*/

    //Get City list
    setState(() {
      _cities = AddressStatics.getCities();
    });

    //Get active city and district
    getAddrInfo().then((List<Placemark> info) {
      setState(() {
        _citySelected = info[0].administrativeArea;
        _districtSelected = info[0].subAdministrativeArea;
      });
    });

    //Get district
    setState(() {
      _districts = getDistrictList(_citySelected ?? "Ankara");
    });

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
                        labelText: "Koordinat",
                      ),
                      //City
                      DropdownComponent(
                        selected: _citySelected,
                        options: _cities,
                        hintText: "İl seçiniz",
                        onChanged: (String selected) {
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
                          icon_name: "restaurant_menu",
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
                          icon_name: "category",
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
                          icon_name: "remove_red_eye",
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
                          icon_name: "color_lens",
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
                          icon_name: "wc",
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
                          icon_name: "event_seat",
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
                          icon_name: "child_care",
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
                          icon_name: "cake",
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
                          icon_name: "calendar_today",
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
                          icon_name: "local_bar",
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
                          icon_name: "work",
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
                        onPressed: () {
                          print(_nameController.text.trim());
                          print(_digestController.text.trim());
                          print(_citySelected.trim());
                          print(_districtSelected.trim());
                          print(_phoneController.text.trim());
                          print(_faxController.text.trim());
                          print(_addressController.text.trim());
                          print(_categorySelected);
                          print(_citySelected);
                          print(_districtSelected);
                          print("İşlem Tamamlandı!");
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
}
