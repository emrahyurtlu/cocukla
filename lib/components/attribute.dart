import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class Attribute extends StatelessWidget {
  final IconData icon;
  final String str;
  final double size;
  final Color color;

  Attribute(
    this.icon,
    this.str, [
    this.color = AppColor.dark_gray,
    this.size = 14,
  ]);

  @override
  Widget build(BuildContext context) {
    var icon = Icon(Icons.launch, size: this.size, color: this.color,);
    return Wrap(
      children: <Widget>[
        icon,
        Text(
          str,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
