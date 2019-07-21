import 'package:cocukla/components/button_component.dart';
import 'package:cocukla/components/dropdown_component.dart';
import 'package:cocukla/components/text_input_component.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaceForm extends StatefulWidget {
  @override
  _PlaceFormState createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _digestController = TextEditingController();
  final _phoneController = TextEditingController();
  final _faxController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _emailController = TextEditingController();
  String dropdownValue;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Yeni Ekle",
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
                //Image Upload
                Container(
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

/*
class PlaceForm extends StatelessWidget {



}
*/
