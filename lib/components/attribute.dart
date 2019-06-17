import 'package:flutter/material.dart';

class Attribute extends StatelessWidget {
  final IconData icon;
  final String str;
  final double size;

  Attribute({this.icon, this.str, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3, right: 3),
      child: Row(
        children: <Widget>[Icon(icon, size: size,), Text(str)],
      ),
    );
  }
}
