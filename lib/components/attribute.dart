import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class Attribute extends StatelessWidget {
  final IconData icon;
  final String str;
  final double size;
  final Color color;


  Attribute(this.icon, this.str, [this.color = AppColor.dark_gray, this.size = 14,]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3, right: 3),
      child: Row(
        children: <Widget>[Icon(icon, size: size,color: color,), Text(str, style: TextStyle(color: color),)],
      ),
    );
  }
}
