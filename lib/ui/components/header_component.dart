import 'package:flutter/material.dart';

class HeaderComponent extends StatefulWidget {
  final String text;

  HeaderComponent(this.text);
  @override
  _HeaderComponentState createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
