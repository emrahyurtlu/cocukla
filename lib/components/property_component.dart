import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/icon_utility.dart';
import 'package:flutter/material.dart';

class PropertyComponent extends StatelessWidget {
  IconData _iconData;
  Icon _icon;
  final String icon_name;
  final String content;
  final double font_size;
  final Color color;
  final EdgeInsets padding;

  PropertyComponent({
    @required this.icon_name,
    @required this.content,
    this.color = AppColor.dark_gray,
    this.font_size = 14,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    this._iconData = getMaterialIconByName(icon_name: icon_name);
    this._icon = Icon(
      _iconData,
      size: this.font_size,
      color: this.color,
    );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        _icon,
        Padding(
          padding: padding,
          child: Text(
            content,
            softWrap: true,
            style: TextStyle(color: color),
          ),
        )
      ],
    );
  }
}
