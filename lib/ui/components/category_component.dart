import 'package:flutter/material.dart';
import 'package:cocukla/ui/config/app_color.dart';

class Category extends StatelessWidget {
  final String imageUrl;
  final String title;

  Category({this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 75,
      height: 80,
      child: Column(
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(this.imageUrl, width: 60, height: 60),
          Text(title,
              style: TextStyle(
                  fontFamily: "MontserratLight",
                  fontSize: 13,
                  color: AppColor.text_color,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
