import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const CardComponent(
      {Key key,
      this.child,
      this.width = double.infinity,
      this.height = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
            border: Border.all(color: Colors.white),
            color: AppColor.white),
        child: this.child);
  }
}
