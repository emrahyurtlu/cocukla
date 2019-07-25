import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/components/place_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/screens/place_form.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  final List<PropertyComponent> attributes = [
    PropertyComponent(
        iconName: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(iconName: "location_on", content: "5.6km"),
    PropertyComponent(iconName: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(iconName: "child_friendly", content: "Bebek bakım odası"),
    PropertyComponent(iconName: "child_care", content: "Oyun odası")
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
                              Icons.search,
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
              child: getMyPlaces(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            PlaceModel model = PlaceModel(
                isActive: true,
                email: "necatibey@hosta.com",
                name: "Hosta Piknik",
                city: "Ankara",
                district: "Çankaya",
                address: "Necatibey Caddesi No:25 Sıhhıye, Çankaya/Ankara",
                category: "Mekanlar",
                digest: "Bu alana mekan hakkında özet bilgi gelecek",
                fax: "0312 111 2233",
                phone: "0312 333 4455",
                isApproved: true,
                location: "",
                owner: AppData.user.email,
                properties: [
                  {
                    "iconName": "restaurant_menu",
                    "content": "Çocuk menüsü",
                  },
                  {
                    "iconName": "child_friendly",
                    "content": "Bebek bakım odası",
                  },
                  {
                    "iconName": "child_care",
                    "content": "Oyun odası",
                  },
                  {
                    "iconName": "calendar_today",
                    "content": "Randevu ile gidilir",
                  },
                  {
                    "iconName": "cake",
                    "content": "Özel gün organizasyonu",
                  },
                ],
                images: [
                  "assets/images/temp/kasibeyaz_atasehir.jpg",
                  "assets/images/temp/gha_3325.jpg",
                  "assets/images/temp/gha_3336.jpg",
                  "assets/images/temp/gha_3499.jpg",
                  "assets/images/temp/gha_3612.jpg",
                ]);
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

Widget getMyPlaces() {
  List<DocumentSnapshot> documents;
  var snapshot = Firestore.instance.document(Collection.Places).snapshots();
  snapshot
      .where((DocumentSnapshot ds) => ds.data["owner"] == AppData.user.email)
      .listen((DocumentSnapshot ds) {
    documents.add(ds);
  });
  if (documents != null) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (BuildContext context, int index) {
          return PlaceComponent(
            id: documents[index].documentID,
            title: documents[index].data["title"],
            rating: (documents[index].data["rating"] as num).toDouble(),
            image: documents[index].data["images"][0],
            properties: documents[index].data["properties"],
            isFav: documents[index].data["isFav"],
          );
        });
  } else {
    return Center(
      child: Text("Kayıt bulunamadı."),
    );
  }
}
