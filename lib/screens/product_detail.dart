import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  ProductModel model;

  ProductDetail(this.model);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
              )
              //Content Row
            ],
          ),
        ),
      ),
    );
  }
}
