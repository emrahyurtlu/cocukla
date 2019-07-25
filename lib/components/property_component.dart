import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/icon_utility.dart';
import 'package:flutter/material.dart';

class PropertyComponent extends StatelessWidget {
  IconData _iconData;
  Icon _icon;
  final String iconName;
  final String content;
  final double fontSize;
  final Color color;
  final EdgeInsets padding;

  PropertyComponent({
    @required this.iconName,
    @required this.content,
    this.color = AppColor.dark_gray,
    this.fontSize = 14,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    this._iconData = getMaterialIconByName(iconName: iconName);
    this._icon = Icon(
      _iconData,
      size: this.fontSize,
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
