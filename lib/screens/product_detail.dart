import 'package:cocukla/components/comment_component.dart';
import 'package:cocukla/components/comment_form_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/components/smart_tab_component.dart';
import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductDetail extends StatefulWidget {
  ProductModel model;

  ProductDetail(this.model);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: AppColor.light_gray),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        widget.model.photos[index].imageLink,
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: widget.model.photos.length,
                    pagination: SwiperPagination(builder: SwiperPagination.dots),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        key: GlobalKey(),
                        children: <Widget>[
                          //Title and favorite button
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: DimensionUtility(context)
                                    .setWidthRel(subtract: 42),
                                child: Stack(
                                  children: <Widget>[
                                    Text(
                                      widget.model.title,
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
                            mainAxisSize: MainAxisSize.min,
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
                                            Tab(
                                              text: "Yorum yapın",
                                            ),
                                          ],
                                          pages: <Page>[
                                            //Hakkımızda
                                            Page(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    widget.model.text,
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
                                                          icon_name: property
                                                              .icon_name,
                                                          content:
                                                              property.text,
                                                          color: property.color,
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
                                                          return CommentComponent(
                                                              model: widget
                                                                      .model
                                                                      .comments[
                                                                  index]);
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                            //Yorum yapın
                                            Page(
                                              child: Column(
                                                children: <Widget>[
                                                  //Head
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 20),
                                                    child: Text("Yorumlarınız bizim için çok değerlidir. Lütfen görüş bildiriniz.", softWrap: true,),
                                                  ),
                                                  CommentFormComponent(
                                                    textEditingController:
                                                    _textEditingController,
                                                  ),
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
          onPressed: () => print(widget.model.phone_number + " is calling..."),
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
