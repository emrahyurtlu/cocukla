import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/config/font_family.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const TextStyle AppBarTextStyle = TextStyle(
      color: AppColor.text_color, fontFamily: FontFamily.MontserratRegular);

  static const TextStyle CommentNameTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: FontFamily.MontserratRegular);

  static const TextStyle CommentContentTextStyle =
      TextStyle(fontSize: 14, fontFamily: FontFamily.MontserratLight);
}
