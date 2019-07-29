import 'package:flutter/material.dart';

class ConditionalComponent extends StatefulWidget {
  final List<Widget> children;
  final bool condition;

  const ConditionalComponent(
      {Key key, @required this.condition, @required this.children})
      : super(key: key);

  @override
  _ConditionalComponentState createState() => _ConditionalComponentState();
}

class _ConditionalComponentState extends State<ConditionalComponent> {
  @override
  Widget build(BuildContext context) {
    if (widget.condition) {
      return Column(
        /*crossAxisAlignment: CrossAxisAlignment.start,*/
        children: widget.children,
      );
    } else {
      return SizedBox(
        width: 0,
        height: 0,
        child: Text(""),
      );
    }
  }
}
