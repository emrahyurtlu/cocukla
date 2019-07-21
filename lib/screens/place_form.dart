import 'dart:core';

import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/dropdown_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/ui/font_family.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cocukla/utilities/device_location.dart';
import 'package:geolocator/geolocator.dart';

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
  static TextEditingController _cityController = TextEditingController();
  static TextEditingController _districtController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  String dropdownValue;
  static Position _location;
  static List<Placemark> _list;
  final _owner = AppData.user["email"];
  final int _rating = 0;
  final comments = [];
  static String insert_date;
  static String update_date;

  var res1 = getLocation().then((pos) => _location = pos);
  var res2 = getAddrInfo().then((List<Placemark> info){
    _cityController.text = info[0].administrativeArea;
    _districtController.text = info[0].subAdministrativeArea;
  });

  @override
  void initState() {
    insert_date = widget.data["insert_date"] != "" ? widget.data["insert_date"] : DateTime.now().toString();
    update_date = DateTime.now().toString();
    _nameController.text = widget.data["name"];
    _digestController.text = widget.data["digest"];
    _phoneController.text = widget.data["phone"];
    _faxController.text = widget.data["fax"];
    _addressController.text = widget.data["address"];
    _emailController.text = widget.data["email"];
    dropdownValue = widget.data["category"] ?? "";
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Yeni Ekle",
              style: TextStyle(
                  color: AppColor.text_color, fontFamily: FontFamily.MontserratRegular)),
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
                Form(
                  key: _formKey,
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Genel Bilgiler", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Divider(indent: 20, endIndent: 20,),
                      //Name Surname
                      TextInputComponent(
                        _nameController,
                        labelText: "Mekan adı giriniz",
                      ),
                      TextInputComponent(
                        _digestController,
                        labelText: "Özet",
                      ),
                      DropdownComponent(
                        selected: dropdownValue,
                        options: [
                          "Mekanlar",
                          "Aktiviteler",
                          "Sağlık",
                          "Alışveriş"
                        ],
                        hintText: "Kategori seçiniz",
                        onChanged: (String selected) {
                          setState(() {
                            dropdownValue = selected;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Adres Bilgiler", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Divider(indent: 20, endIndent: 20,),
                      TextInputComponent(
                        _cityController,
                        labelText: "İl",
                      ),
                      TextInputComponent(
                        _districtController,
                        labelText: "İlçe",
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
                      Divider(indent: 20, endIndent: 20,),

                      ButtonComponent(
                        text: "Kaydet",
                        onPressed: () {
                          print(_nameController.text.trim());
                          print(_digestController.text.trim());
                          print(_cityController.text.trim());
                          print(_districtController.text.trim());
                          print(_phoneController.text.trim());
                          print(_faxController.text.trim());
                          print(_addressController.text.trim());
                          print(dropdownValue);
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
