import 'package:cocukla/components/product_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/screens/place_form.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  final List<PropertyComponent> attributes = [
    PropertyComponent(
        icon_name: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(icon_name: "location_on", content: "5.6km"),
    PropertyComponent(icon_name: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(
        icon_name: "child_friendly", content: "Bebek bakım odası"),
    PropertyComponent(icon_name: "child_care", content: "Oyun odası")
  ];

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mekanlarım",
              style: TextStyle(
                  color: AppColor.text_color, fontFamily: "MontserratRegular")),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: Column(
          children: <Widget>[
            //Search
            Container(
              width: double.infinity,
              height: 70,
              margin: EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  border: Border.all(color: Colors.white),
                  color: AppColor.white),
              child: Row(
                children: <Widget>[
                  Form(
                    key: GlobalKey(),
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 280,
                          height: 48,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 0, top: 0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColor.light_gray,
                                  ),
                                  child: TextFormField(
                                    controller: null,
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      labelStyle:
                                          TextStyle(color: AppColor.text_color),
                                      labelText: "Mekan arayın",
                                      //hintText: "Ara",
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 25, top: 5),
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    width: 10,
                    height: 40,
                  ),
                  SizedBox(
                      width: 60,
                      height: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.pink,
                        ),
                        child: Container(
                          width: 60,
                          height: 40,
                          child: FlatButton(
                            color: AppColor.pink,
                            textColor: AppColor.white,
                            onPressed: () => {print("From Filter Button")},
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0)),
                            child: Icon(
                              Icons.tune,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            //End Search

            //Product List
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Product(
                    id: 1,
                    title: "Fevzi Usta Köfte&Balık",
                    imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                    rating: 5,
                    attributes: widget.attributes,
                    isFav: true,
                  ),
                  Product(
                    id: 2,
                    title: "Kaşıbeyaz Ataşehir",
                    imageUrl: "assets/images/temp/kasibeyaz_atasehir.jpg",
                    rating: 3,
                    attributes: widget.attributes,
                    isFav: true,
                  ),
                  Product(
                    id: 3,
                    title: "Trilye Restaurant",
                    imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                    rating: 4.5,
                    attributes: widget.attributes,
                    isFav: true,
                  ),
                  Product(
                    id: 4,
                    title: "Mado Bahçelievler",
                    imageUrl: "assets/images/temp/mado.jpg",
                    rating: 3,
                    attributes: widget.attributes,
                    isFav: true,
                  ),
                ],
              ),
            ),
            //Product List
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            var map = Map<String, dynamic>();
            map = {
              "id":"",
              "name": "Hosta Piknik",
              "digest": "özet alanı",
              "insert_date": "",
              "update_date": "",
              "phone": "0312 333 4455",
              "fax": "0312 111 2233",
              "email": "necatibey@hosta.com",
              "address": "Necatibey Caddesi ...",
              "category": "Mekanlar",
              "city": "Ankara",
              "district": "Çankaya",
              "coordinate": ""
            };
            PlaceModel model = PlaceModel.fromJson(map);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceForm(model)),
            );
          },
        ),
      ),
    );
  }
}
