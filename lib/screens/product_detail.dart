import 'package:cocukla/components/attribute.dart';
import 'package:cocukla/components/smart_tab.dart';
import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetail extends StatefulWidget {
  ProductModel model;

  ProductDetail(this.model);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.model.title,
              style: TextStyle(
                  color: AppColor.text_color, fontFamily: "MontserratRegular")),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Image
              Container(
                width: double.infinity,
                height: 220,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.model.photos[0].imageLink,
                      fit: BoxFit.cover,
                    )),
              ),

              //Content Section
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
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
                                minHeight: 400.0
                            ),
                            height: 0,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: SmartTab(
                                    tabs: <Tab>[
                                      Tab(
                                        text: "Özellikler",
                                      ),
                                      Tab(
                                        text: "Fotoğraflar",
                                      ),
                                      Tab(
                                        text: "Yorumlar",
                                      ),
                                      Tab(
                                        text: "Hakkımızda",
                                      ),
                                    ],
                                    pages: <Page>[
                                      Page(
                                        child: ListView.builder(
                                            itemCount: widget.model.properties.length,
                                            itemBuilder: (BuildContext context, int index) {
                                          return Attribute(IconData(0xe895), widget.model.properties[index].text);
                                        }),
                                      ),
                                      Page(
                                        child: Text("Page 2"),
                                      ),
                                      Page(
                                        child: Text("Page 3"),
                                      ),
                                      Page(
                                        child: Text("Page 4"),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        )
                      ],
                    ),

                    //End Tabs
                  ],
                ),
              ),


            ],
          ),
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
