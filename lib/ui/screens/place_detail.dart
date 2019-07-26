import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/ui/components/comment_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/smart_tab_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
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

  @override
  void initState() {
    isFav = widget.data["isFav"];
  }

  @override
  void dispose() {
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            //Place Photos
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              flexibleSpace: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(color: AppColor.light_gray),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        widget.data["images"][index],
                        fit: BoxFit.fill,
                      );
                    },
//                    itemCount: widget.model.photos.length,
                    itemCount: widget.data["images"].length,
                    pagination:
                        SwiperPagination(builder: SwiperPagination.dots),
                  ),
                ),
              ),
            ),
            //Content Section
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Content Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(10, 10)),
                          border: Border.all(color: Colors.white),
                          color: AppColor.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        key: GlobalKey(),
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
                                  rating: double.parse(widget.data["rating"]),
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

                          //Tabs
                          Column(
                            children: <Widget>[
                              Container(
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity,
                                      maxWidth: double.infinity,
                                      minWidth: double.infinity,
                                      minHeight: 200.0),
                                  height: 400,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: SmartTab(
                                          tabs: <Tab>[
                                            Tab(
                                              text: "Hakkımızda",
                                            ),
                                            Tab(
                                              text: "Özellikler",
                                            ),
                                            Tab(
                                              text: "Yorumlar",
                                            ),
                                          ],
                                          pages: <Page>[
                                            //Hakkımızda
                                            Page(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    widget.data["digest"],
                                                    softWrap: true,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    width: double.infinity,
                                                    child: PropertyComponent(
                                                      iconName: "phone",
                                                      content: "0850 441 2020",
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width: double.infinity,
                                                    child: PropertyComponent(
                                                      iconName: "print",
                                                      content: "0212 441 2040",
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width: double.infinity,
                                                    child: PropertyComponent(
                                                      iconName: "location_on",
                                                      content:
                                                          "Barbaros Mah. Şebboy Sok. No:2 \nWatergarden İş Merkezi \nAtaşehir/İstanbul",
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //Özellikler
                                            Page(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: Map.from(widget
                                                          .data["properties"])
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var property = widget
                                                            .data["properties"]
                                                        [index];
                                                    return Container(
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      child: PropertyComponent(
                                                          iconName: property[
                                                              "iconName"],
                                                          content: property[
                                                              "content"],
                                                          fontSize: 18,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5)),
                                                    );
                                                  }),
                                            ),

                                            //Yorumlar
                                            Page(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  //Comment It
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 60,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          child: FlatButton(
                                                            color:
                                                                AppColor.pink,
                                                            textColor:
                                                                AppColor.white,
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CommentScreen(
                                                                              documentID: widget.documentID,
                                                                            )),
                                                              );
                                                            },
                                                            shape: new RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        50.0)),
                                                            child: Text(
                                                              "Yorum yapın",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //List of comments
                                                  Row(
                                                    children: <Widget>[
                                                      //Comments
                                                      ListView.builder(
                                                        itemCount: Map.from(
                                                                widget.data[
                                                                    "comments"])
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return CommentComponent(
                                                              model: CommentModel
                                                                  .fromJson(widget
                                                                              .data[
                                                                          "comments"]
                                                                      [index]));
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),

                          //End Tabs
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
}
