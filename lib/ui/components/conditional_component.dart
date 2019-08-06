import 'package:flutter/material.dart';

class ConditionalComponent extends StatefulWidget {
  final Widget child;
  final bool condition;
  final Widget otherWise;

  const ConditionalComponent(
      {Key key,
      @required this.condition,
      @required this.child,
      this.otherWise})
      : super(key: key);

  @override
  _ConditionalComponentState createState() => _ConditionalComponentState();
}

class _ConditionalComponentState extends State<ConditionalComponent> {
  Widget nullWidget = SizedBox(
    width: 0,
    height: 0,
    child: Text(""),
  );

  @override
  Widget build(BuildContext context) {
    if (widget.condition) {
      return widget.child;
    } else {
      return widget.otherWise ?? nullWidget;
    }
  }
}
