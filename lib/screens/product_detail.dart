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
  TabController _tabBarController;

  @override
  void initState() {
    _tabBarController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

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
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Bu alana tab gelecek!"),
                          Expanded(
                            child: TabBar(
                              controller: _tabBarController,
                              isScrollable: true,
                              tabs: <Widget>[
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
                                  text: "Hakkında",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabBarController,
                              children: <Widget>[
                                Text("Özellikler"),
                                Text("Fotoğraflar"),
                                Text("Yorumlar"),
                                Text("Hakkında"),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                    //End Tabs
                  ],
                ),
              )
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
