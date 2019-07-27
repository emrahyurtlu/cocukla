import 'package:cocukla/ui/components/category_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';

class HomeCategories extends StatefulWidget {
  @override
  _HomeCategoriesState createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
