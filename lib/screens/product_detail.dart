import 'package:cocukla/components/comment_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/components/smart_tab_component.dart';
import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/photo_model.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/models/property_model.dart';
import 'package:cocukla/screens/comment_screen.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductDetail extends StatefulWidget {
  PlaceModel model = PlaceModel(
      id: "1",
      name: "Kaşıbeyaz Ataşehir",
      city: "İstanbul",
      district: "Ataşehir",
      owner: "1",
      isFav: true,
      phone: "02122252244",
      rating: 4,
      email: "atasehir@kasiyeyaz.com",
      fax: "02125554411",
      digest:
      "Kaşıbeyaz restaurant 1980 yılında Gaziantep'te kurulmuştur. Kurulduğu günden beri kaliteden ödün vermeden hizmet sektöründe iş yaşamına devam etmiştir.",
      address: "Yeşiltepe Mah. Konyalı Sok. No:24 Ataşehir/İstanbul",
      comments: [
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Abdullah O.",
            rating: 4,
            text:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            date: DateTime.now()),
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Mehmet S.",
            rating: 5,
            text:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
            date: DateTime.now()),
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Bayram T.",
            rating: 3,
            text:
            "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            date: DateTime.now()),
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Emrah Y.",
            rating: 5,
            text:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            date: DateTime.now()),
      ],
      photos: [
        "assets/images/temp/kasibeyaz_atasehir.jpg",
        "assets/images/temp/gha_3325.jpg",
        "assets/images/temp/gha_3336.jpg",
        "assets/images/temp/gha_3499.jpg",
        "assets/images/temp/gha_3612.jpg",
      ],
      /*properties: [
        PropertyModel(
            iconName: "access_time",
            text: "10:00-00:00 arası hizmet vermektedir",
            color: AppColor.green),
        PropertyModel(
            iconName: "location_on",
            text: "5.6km",
            color: AppColor.dark_gray),
        PropertyModel(
            iconName: "restaurant_menu",
            text: "Çocuk menüsü",
            color: AppColor.dark_gray),
        PropertyModel(
            iconName: "child_friendly",
            text: "Bebek bakım odası",
            color: AppColor.dark_gray),
        PropertyModel(
            iconName: "child_care",
            text: "Oyun odası",
            color: AppColor.dark_gray),
        PropertyModel(
            iconName: "calendar_today",
            text: "Randevu ile gidilir",
            color: AppColor.dark_gray),
        PropertyModel(
            iconName: "cake",
            text: "Organizasyon yapılır",
            color: AppColor.dark_gray),
      ]*/);

  ProductDetail(this.model);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery
                  .of(context)
                  .size
                  .height * 0.35,
              flexibleSpace: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.35,
                decoration: BoxDecoration(color: AppColor.light_gray),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        widget.model.photos[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: widget.model.photos.length,
                    pagination:
                    SwiperPagination(builder: SwiperPagination.dots),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.65,
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
                                      widget.model.name,
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
                                          icon: Icon(widget.model.isFav
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
                                  rating: widget.model.rating,
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
                                                    widget.model.digest,
                                                    softWrap: true,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    width: double.infinity,
                                                    child: PropertyComponent(
                                                      icon_name: "phone",
                                                      content: "0850 441 2020",
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      font_size: 18,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width: double.infinity,
                                                    child: PropertyComponent(
                                                      icon_name: "print",
                                                      content: "0212 441 2040",
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      font_size: 18,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width: double.infinity,
                                                    child: PropertyComponent(
                                                      icon_name: "location_on",
                                                      content:
                                                      "Barbaros Mah. Şebboy Sok. No:2 \nWatergarden İş Merkezi \nAtaşehir/İstanbul",
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      font_size: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //Özellikler
                                            Page(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: widget
                                                      .model.properties.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    var property = widget.model
                                                        .properties[index];
                                                    return Container(
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      child: PropertyComponent(
                                                          icon_name: property[1],
                                                          content:
                                                          property[0],
                                                          font_size: 18,
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
                                                                        (
                                                                        context) =>
                                                                        CommentScreen(
                                                                          model: widget
                                                                              .model,
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
                                                  Column(
                                                    children: <Widget>[
                                                      //Comments
                                                      ListView.builder(
                                                        itemCount: widget.model
                                                            .comments.length,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext
                                                        context,
                                                            int index) {
                                                          return Expanded(
                                                            child: CommentComponent(
                                                                model: widget
                                                                    .model
                                                                    .comments[
                                                                index]),
                                                          );
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
          onPressed: () => print(widget.model.phone + " is calling..."),
        ),
      ),
    );
  }

  void favOnPress() {
    print("Fav id is " + widget.model.id.toString());
    setState(() {
      widget.model.isFav = !widget.model.isFav;
    });
  }
}
