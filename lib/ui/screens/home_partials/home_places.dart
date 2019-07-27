import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/ui/components/category_component.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

import '../place_detail.dart';

class HomePlaces extends StatefulWidget {
  @override
  _HomePlacesState createState() => _HomePlacesState();
}

class _HomePlacesState extends State<HomePlaces> {
  TextEditingController controller;
  List<DocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          //Search
          SearchFormComponent(
            controller: controller,
            onPressed: () {},
          ),
          //End Search

          //Categories
          Container(
            width: double.infinity,
            height: 90,
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                border: Border.all(color: Colors.white),
                color: AppColor.white),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  child: Category(
                    imageUrl: "assets/images/place.png",
                    title: "Mekanlar",
                  ),
                  onTap: () {
                    //setTitle("Mekanlar");
                  },
                ),
                GestureDetector(
                  child: Category(
                    imageUrl: "assets/images/activity.png",
                    title: "Aktiviteler",
                  ),
                  onTap: () {
                    //setTitle("Aktiviteler");
                  },
                ),
                GestureDetector(
                    child: Category(
                      imageUrl: "assets/images/health.png",
                      title: "Sağlık",
                    ),
                    onTap: () {
                      //setTitle("Sağlık");
                    }),
                GestureDetector(
                    child: Category(
                      imageUrl: "assets/images/shopping.png",
                      title: "Alışveriş",
                    ),
                    onTap: () {
                      //setTitle("Alışveriş");
                    }),
              ],
            ),
          ),
          //End Categories

          //Product List
          Expanded(
            child: getPlaces(),
          ),
          //Product List
        ],
      ),
    );
  }

  Widget getPlaces() {
    if (documents != null) {
      print("GETTIN LIST OF WIDGETS.");
      return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            //test(documents[index]);
            return PlaceComponent(
              documentID: documents[index].documentID,
              title: documents[index]["name"],
              rating: double.parse(documents[index]["rating"]),
              image: documents[index]["images"][0],
              properties: convertProperties(documents[index]["properties"]),
              isFav: documents[index].data["isFav"],
              onTap: () {
                redirecTo(
                    context,
                    PlaceDetail(
                      documentID: documents[index].documentID,
                      data: documents[index].data,
                    ));
              },
            );
          });
    } else {
      return Center(
        child: Text("İçerik bulunamadı."),
      );
    }
  }

  List<PropertyComponent> convertProperties(List properties) {
    var result = List<PropertyComponent>();

    if (properties.length > 0) {
      properties.forEach((item) {
        var temp = PropertyComponent(
            iconName: item["iconName"], content: item["content"]);
        result.add(temp);
      });
    }
    return result;
  }
}
