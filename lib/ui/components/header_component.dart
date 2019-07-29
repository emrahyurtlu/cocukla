import 'package:flutter/material.dart';

class HeaderComponent extends StatefulWidget {
  String text;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;
  TextStyle style;
  EdgeInsetsGeometry padding;

  double indent, endIndent;

  HeaderComponent(this.text,
      {this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.style = const TextStyle(fontWeight: FontWeight.bold),
      this.padding = const EdgeInsets.all(8.0),
      this.indent = 0,
      this.endIndent = 0});

  @override
  _HeaderComponentState createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: <Widget>[
        Padding(
          padding: widget.padding,
          child: Text(
            widget.text,
            style: widget.style,
          ),
        ),
        Divider(
          indent: widget.indent,
          endIndent: widget.endIndent,
        ),
      ],
    );
  }
}
