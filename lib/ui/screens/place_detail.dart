import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/comment_component.dart';
import 'package:cocukla/ui/components/header_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'comment_screen.dart';

class PlaceDetail extends StatefulWidget {
  Map<String, dynamic> data;
  final String documentID;

  PlaceDetail({Key key, this.documentID, this.data}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  FirebaseUser user;
  bool isFav = false;
  List<String> images;
  List<PropertyComponent> properties;
  List<CommentComponent> comments;

  @override
  void initState() {
    isFav = widget.data["isFav"];
    print("Here is place detail screen!");
    images = List.castFrom(widget.data["images"]);
    properties = convertProperties(widget.data["properties"]);
    comments = convertComments(widget.data["comments"]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.data["name"],
            style: AppStyle.AppBarTextStyle,
          ),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              //Place Photos
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(color: AppColor.light_gray),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.fill,
                      );
                    },
//                    itemCount: widget.model.photos.length,
                    itemCount: images.length,
                    pagination:
                        SwiperPagination(builder: SwiperPagination.dots),
                  ),
                ),
              ),
              //Content Section
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                //height: MediaQuery.of(context).size.height*2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Content Section
                    Card(
                      elevation: 0,
                      color: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Title and favorite button
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: DimensionUtility(context)
                                        .setWidthRel(subtract: 42),
                                    child: Stack(
                                      children: <Widget>[
                                        Text(
                                          widget.data["name"],
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: "MontserratRegular",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.text_color),
                                        ),
                                        Positioned(
                                          width: 30,
                                          height: 30,
                                          child: Container(
                                            color: Colors.white,
                                            child: IconButton(
                                              icon: Icon(isFav
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
                                ],
                              ),
                              //End Title and favorite button
                              //Rating
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: FlutterRatingBarIndicator(
                                      rating:
                                          double.parse(widget.data["rating"]),
                                      itemCount: 5,
                                      itemSize: 15,
                                      emptyColor: AppColor.dark_gray,
                                      fillColor: AppColor.yellow,
                                      itemPadding: EdgeInsets.only(right: 2),
                                    ),
                                  ),
                                ],
                              ),
                              //End Rating

                              HeaderComponent(
                                "Hakkımızda",
                                crossAxisAlignment: CrossAxisAlignment.start,
                                padding: EdgeInsets.only(top: 20),
                              ),
                              Text(
                                widget.data["digest"],
                                softWrap: true,
                                textAlign: TextAlign.left,
                              ),
                              HeaderComponent(
                                "İletişim",
                                crossAxisAlignment: CrossAxisAlignment.start,
                                padding: EdgeInsets.only(top: 20),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                width: double.infinity,
                                child: PropertyComponent(
                                  iconName: "phone",
                                  content: widget.data["phone"],
                                  padding: EdgeInsets.only(left: 10),
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                child: PropertyComponent(
                                  iconName: "location_on",
                                  content: widget.data["address"],
                                  padding: EdgeInsets.only(left: 10),
                                  fontSize: 18,
                                ),
                              ),
                              HeaderComponent(
                                "Özellikler",
                                crossAxisAlignment: CrossAxisAlignment.start,
                                padding: EdgeInsets.only(top: 20),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: properties.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var propertyComponent = properties[index];
                                    propertyComponent.fontSize = 18;
                                    propertyComponent.padding =
                                        EdgeInsets.only(left: 5);
                                    return Container(
                                        width: double.infinity,
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: propertyComponent);
                                  }),
                              HeaderComponent(
                                "Yorumlar",
                                crossAxisAlignment: CrossAxisAlignment.start,
                                padding: EdgeInsets.only(top: 20),
                              ),
                              //Comment It
                              ButtonComponent(
                                text: "Yorum yapın",
                                onPressed: () {
                                  redirecTo(
                                      context,
                                      CommentScreen(
                                        documentID: widget.documentID,
                                      ));
                                },
                              ),
                              //List of comments
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: comments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return comments[index];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.phone),
          onPressed: () {
            if (widget.data["phone"].isNotEmpty)
              launch("tel:" + widget.data["phone"]);
          },
        ),
      ),
    );
  }

  void favOnPress() {
    print("Fav id is:" + widget.documentID);
    setState(() {
      widget.data["isFav"] = !widget.data["isFav"].isFav;
    });
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

  List<CommentComponent> convertComments(List properties) {
    var result = List<CommentComponent>();

    if (properties.length > 0) {
      properties.forEach((item) {
        var model = CommentModel(
            rating: double.parse(item["rating"].toString()),
            name: item["name"],
            content: item["content"],
            date: item["date"],
            image: item["image"]);
        var temp = CommentComponent(
          model: model,
        );

        result.add(temp);
      });
    }
    return result;
  }
}
