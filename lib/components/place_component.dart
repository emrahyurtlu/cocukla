import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlaceComponent extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final double rating;
  final List<PropertyComponent> properties;
  bool isFav;

  PlaceComponent(
      {Key key,
      this.id,
      this.title,
      this.image,
      this.rating,
      this.properties,
      this.isFav})
      : super(key: key);


  @override
  _PlaceComponentState createState() => _PlaceComponentState();
}

class _PlaceComponentState extends State<PlaceComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 87,
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
          border: Border.all(color: Colors.white),
          color: AppColor.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Image Section
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed("/product-detail"),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),

          //Info Section
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Title Section
              Container(
                width:
                    DimensionUtility(context, EdgeInsets.only(top: 5, left: 10))
                        .setWidthRel(subtract: 100),
                height: 30,
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed("/product-detail"),
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: "MontserratLight",
                            fontSize: 18,
                            color: AppColor.text_color),
                      ),
                    ),
                    Positioned(
                      width: 30,
                      height: 30,
                      child: Container(
                        color: Colors.white,
                        child: IconButton(
                          icon: Icon(widget.isFav
                              ? Icons.favorite
                              : Icons.favorite_border),
                          iconSize: 24,
                          padding: EdgeInsets.all(0),
                          onPressed: favOnPress,
                          color: AppColor.pink,
                        ),
                      ),
                      top: 0,
                      right: 0,
                    ),
                  ],
                ),
              ),
              //Rating
              Container(
                padding: EdgeInsets.only(top: 0, left: 10),
                child: Row(
                  children: <Widget>[
                    FlutterRatingBarIndicator(
                      rating: widget.rating,
                      itemCount: 5,
                      itemSize: 15,
                      emptyColor: AppColor.dark_gray,
                      fillColor: AppColor.yellow,
                      itemPadding: EdgeInsets.only(right: 2),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed("/product-detail"),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 304,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    runSpacing: 0,
                    spacing: 3,
                    children: widget.properties,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void favOnPress() {
    print("Fav id is " + widget.id.toString());
    setState(() {
      widget.isFav = !widget.isFav;
    });
  }
}
