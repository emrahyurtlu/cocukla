import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/icon_utility.dart';
import 'package:flutter/material.dart';

class PropertyComponent extends StatelessWidget {
  IconData _iconData;
  Icon _icon;
  String iconName;
  String content;
  double fontSize;
  Color color;
  EdgeInsets padding;

  PropertyComponent.fromJson(Map<String, dynamic> json)
      : iconName = json["iconName"],
        content = json["content"],
        fontSize = 14,
        color = AppColor.dark_gray,
        padding = const EdgeInsets.all(0);

  PropertyComponent({
    @required this.iconName,
    @required this.content,
    this.color = AppColor.dark_gray,
    this.fontSize = 14,
    this.padding = const EdgeInsets.all(0),
  })  : assert(iconName != null, "IconName cannot be null"),
        assert(content != null, "Content cannot be null");

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
            content ?? "",
            softWrap: true,
            style: TextStyle(color: color),
          ),
        )
      ],
    );
  }




}
