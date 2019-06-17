import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComponentTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
            border: Border.all(color: Colors.white),
            color: AppColor.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[Image.asset("assets/images/avatar.png")],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  width: DimensionUtility(context, EdgeInsets.only(top: 5, left: 10)).setWidthRelatively(subtract: 110),
                  height: 50,
                  padding: EdgeInsets.only(top: 5, left: 10),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      Text(
                        "Fevzi Usta",
                        style: TextStyle(
                            fontFamily: "MontserratLight",
                            fontSize: 20,
                            color: AppColor.text_color),
                      ),
                      Positioned(
                        width: 30,
                        height: 50,

                        child: IconButton(
                          icon: Icon(Icons.favorite_border),
                          iconSize: 24,
                          onPressed: () => print("Added to Favorites!"),
                          color: AppColor.dark_gray,
                          highlightColor: AppColor.pink,
                          splashColor: AppColor.green,
                        ),
                        top: 0,
                        right: 0,
                      )
                    ],
                  ),
                )
                /* Padding(
                            padding: EdgeInsets.only(top: 5, left: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Fevzi Usta",
                                  style: TextStyle(
                                      fontFamily: "MontserratLight", fontSize: 20),
                                ),
                                Positioned(
                                  width: 20,
                                  height: 20,
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () => print("Added to favorites!"),
                                    padding: EdgeInsets.all(0),
                                  ),
                                )
                              ],
                            ),
                          )*/
                /*Row(
                            children: <Widget>[
                              Attribute(
                                icon: Icons.bookmark,
                                str: "5km mesafe",
                              ),
                              Attribute(
                                icon: Icons.book,
                                str: "11",
                              ),
                              Attribute(
                                icon: Icons.search,
                                str: "22",
                              ),
                              Attribute(
                                icon: Icons.tune,
                                str: "333",
                              ),
                            ],
                          )*/
              ],
            )
          ],
        ),
      )),
    );
  }
}
