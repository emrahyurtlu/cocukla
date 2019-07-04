import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class PropertyModel {
  int turn;
  String icon_name;
  String text;
  double size;
  Color color;

  PropertyModel(
      {this.turn,
      this.icon_name,
      this.text,
      this.size = 14,
      this.color = AppColor.dark_gray});
}
