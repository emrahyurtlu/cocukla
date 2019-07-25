import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

void processing(BuildContext context,
    {String message = "İşleminiz devam ediyor", bool dismiss = false}) {
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
      },
      barrierDismissible: dismiss);
}
