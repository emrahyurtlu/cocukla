import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/user_service.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlaceComponent extends StatefulWidget {
  final DocumentSnapshot document;
  final String documentID;
  final String title;
  final String image;
  final double rating;
  final List<PropertyComponent> properties;
  final GestureTapCallback onTap;
  final bool isFav;
  final VoidCallback favoriteOnPressedCallback;

  PlaceComponent(
      {Key key,
      this.documentID,
      @required this.onTap,
      @required this.title,
      @required this.image,
      @required this.favoriteOnPressedCallback,
      this.rating = 0,
      this.properties,
      this.isFav,
      this.document})
      : super(key: key);

  @override
  _PlaceComponentState createState() => _PlaceComponentState();
}

class _PlaceComponentState extends State<PlaceComponent> {
  bool isFav = false;
  IconData iconData;
  UserService _userService;

  @override
  void initState() {
    isFav = widget.isFav ? widget.isFav : false;
    //consoleLog("Fav State of Place: $isFav");
    setIconData(isFav);
    _userService = UserService();
    super.initState();
  }

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
          Wrap(
            children: <Widget>[
              //Image Section
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.onTap,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.image,
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                    width: DimensionUtility(
                            context, EdgeInsets.only(top: 5, left: 10))
                        .setWidthRel(subtract: 100),
                    height: 30,
                    padding: EdgeInsets.only(top: 5, left: 10),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "MontserratLight",
                                fontSize: 18,
                                color: AppColor.text_color),
                          ),
                        ),
                        //Favorite Button
                        Positioned(
                          width: 30,
                          height: 30,
                          child: Container(
                            color: Colors.white,
                            child: IconButton(
                              icon: Icon(iconData),
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
                  GestureDetector(
                    child: Container(
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
                    onTap: widget.onTap,
                  ),

                  GestureDetector(
                    onTap: widget.onTap,
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
        ],
      ),
    );
  }

  void favOnPress() async {
    var result =
        await _userService.favorite(AppData.user.email, widget.documentID);
    var user = await _userService.getUser(AppData.user.email);
    consoleLog("Fav result: $result");
    consoleLog("Place isFav: $result");
    setState(() {
      isFav = result;
      setIconData(result);
      AppData.user = user;
    });
    widget.favoriteOnPressedCallback();
  }

  setIconData(bool isFav) {
    this.iconData = isFav ? Icons.favorite : Icons.favorite_border;
  }
}
