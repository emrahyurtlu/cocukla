import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';

void processing(BuildContext context,
    {String message = "İşleminiz devam ediyor"}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.pink),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(message),
              )
            ],
          ),
        );
      });
}
