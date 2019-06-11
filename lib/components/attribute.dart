import 'package:flutter/material.dart';

class Attribute extends StatelessWidget {
  IconData icon;
  String str;

  Attribute({this.icon, this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3, right: 3),
      child: Row(
        children: <Widget>[Icon(icon), Text(str)],
      ),
    );
  }
}
