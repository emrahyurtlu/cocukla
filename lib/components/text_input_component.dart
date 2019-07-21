import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class TextInputComponent extends StatefulWidget {
  final TextEditingController controller;
  final double width, height;
  final TextInputType inputType;
  final String labelText, hintText;
  final EdgeInsetsGeometry contentPadding;
  final int maxLines;
  final bool obscureText;

  TextInputComponent(this.controller,
      {this.width = 300,
      this.height = 60,
      this.inputType = TextInputType.text,
      this.labelText,
      this.hintText,
      this.maxLines = 1,
      this.obscureText = false,
      this.contentPadding =
          const EdgeInsets.only(left: 25, top: 5, bottom: 5, right: 5)});

  @override
  _TextInputComponentState createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColor.light_gray,
              ),
              child: TextFormField(
                controller: widget.controller,
                keyboardType: widget.inputType,
                maxLines: widget.maxLines,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: AppColor.text_color),
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  contentPadding: widget.contentPadding,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
