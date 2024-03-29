import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonComponent extends StatefulWidget {
  final double width, height;
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color color, textColor;

  ButtonComponent(
      {this.width = 300,
      this.height = 60,
      this.icon,
      this.text,
      @required this.onPressed,
      this.color = AppColor.pink,
      this.textColor = AppColor.white});

  @override
  _ButtonComponentState createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 50,
            child: FlatButton(
              color: widget.color,
              textColor: widget.textColor,
              onPressed: widget.onPressed,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              child: widget.icon ??
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
