import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar implements PreferredSizeWidget {
  MyAppBar({this.my_title});

  final String my_title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(my_title, style: TextStyle(color: AppColor.green,)),
      backgroundColor: AppColor.white,
      centerTitle: true,
    );
  }
}
