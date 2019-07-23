import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Widget child;

  const CardComponent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
            border: Border.all(color: Colors.white),
            color: AppColor.white),
        child: this.child
    );
  }
}
