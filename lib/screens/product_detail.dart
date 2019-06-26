import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/ui/app_color.dart';
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
    // TODO: implement initState
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
          margin: EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Image Row
              Row(
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset(
                      "assets/images/temp/kasibeyaz_atasehir.jpg",
                      width: 340,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              //Content Row
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                    border: Border.all(color: Colors.white),
                    color: AppColor.white),
                child: Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetail(ProductModel(
                                            title: "Kaşıbeyaz Ataşehir",
                                          ))),
                                )
                              },
                          child: Text(
                            widget.model.title,
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
                    Container(
                      padding: EdgeInsets.only(top: 0, left: 10),
                      child: Row(
                        children: <Widget>[
                          FlutterRatingBarIndicator(
                            rating: widget.model.rating,
                            itemCount: 5,
                            itemSize: 15,
                            emptyColor: AppColor.dark_gray,
                            fillColor: AppColor.yellow,
                            itemPadding: EdgeInsets.only(right: 2),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      controller: _tabBarController,
                      key: GlobalKey(),
                      tabs: <Widget>[
                        Tab(
                          text: "Özellikler",
                          child: Container(
                            child: Text("Tab 1"),
                          ),
                        ),
                        Tab(
                          text: "Fotoğraflar",
                          child: Container(
                            child: Text("Tab 2"),
                          ),
                        ),
                        Tab(
                          text: "Hakkında",
                          child: Container(
                            child: Text("Tab 3"),
                          ),
                        ),
                        Tab(
                          text: "Yorumlar",
                          child: Container(
                            child: Text("Tab 4"),
                          ),
                        ),
                      ],
                      onTap: (int index) => {print("$index . tab is showed!")},
                    )
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
