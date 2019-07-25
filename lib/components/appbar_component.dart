import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar implements PreferredSizeWidget {
  MyAppBar({this.myTitle});

  final String myTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(myTitle, style: TextStyle(color: AppColor.green,)),
      backgroundColor: AppColor.white,
      centerTitle: true,
    );
  }
}
