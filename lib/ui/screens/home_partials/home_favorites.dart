import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';

class HomeFavorites extends StatefulWidget {
  @override
  _HomeFavoritesState createState() => _HomeFavoritesState();
}

class _HomeFavoritesState extends State<HomeFavorites> {
  TextEditingController controller;
  List<PropertyComponent> attributes = [
    PropertyComponent(
        iconName: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(iconName: "location_on", content: "5.6km"),
    PropertyComponent(iconName: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(iconName: "child_friendly", content: "Bebek bakım odası"),
    PropertyComponent(iconName: "child_care", content: "Oyun odası")
  ];

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

          //Product List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                PlaceComponent(
                  documentID: "1",
                  title: "Fevzi Usta Köfte&Balık",
                  image: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 5,
                  properties: attributes,
                  isFav: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
          //Product List
        ],
      ),
    );
  }
}
