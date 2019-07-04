import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/icon_utility.dart';
import 'package:flutter/material.dart';

class Attribute extends StatelessWidget {
  IconData _iconData;
  Icon _icon;
  final String icon_name;
  final String str;
  final double size;
  final Color color;

  Attribute(
    this.icon_name,
    this.str, [
    this.color = AppColor.dark_gray,
    this.size = 14,
  ]);

  @override
  Widget build(BuildContext context) {
    this._iconData = getMaterialIconByName(icon_name: icon_name);
    this._icon = Icon(
      _iconData,
      size: this.size,
      color: this.color,
    );
    return Wrap(
      children: <Widget>[
        _icon,
        Text(
          str,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
