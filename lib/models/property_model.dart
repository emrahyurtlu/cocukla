import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class PropertyModel {
  int turn;
  String iconName;
  String text;
  double size;
  Color color;
  EdgeInsets padding;

  PropertyModel(
      {this.turn,
      this.iconName,
      this.text,
      this.size = 14,
      this.color = AppColor.dark_gray,
      this.padding = const EdgeInsets.all(0)});
}
