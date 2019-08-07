import 'package:cocukla/ui/components/conditional_component.dart';
import 'package:flutter/material.dart';

class HeaderComponent extends StatefulWidget {
  final String text;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final bool showDivider;

  final double indent, endIndent;

  HeaderComponent(this.text,
      {this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.style = const TextStyle(fontWeight: FontWeight.bold),
      this.padding = const EdgeInsets.all(8.0),
      this.indent = 0,
      this.endIndent = 0,
      this.showDivider = true});

  @override
  _HeaderComponentState createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return ConditionalComponent(condition: widget.showDivider, child: Column(
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
    ),
    otherWise: Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: <Widget>[
        Padding(
          padding: widget.padding,
          child: Text(
            widget.text,
            style: widget.style,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),);
  }
}
