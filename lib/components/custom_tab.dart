import 'dart:core';

import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {
  TabController controller;
  List<Tab> tabs;
  List<Widget> content;

  CustomTab({this.controller, @required this.tabs, @required this.content})
      : assert(tabs.isNotEmpty, "Tab length is equal to 0"),
        assert(content.isNotEmpty, "Tab content length is equal to 0");

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //HeaderSection
          Row(
            /*crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,*/
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text("Tab 1"),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text("Tab 2"),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text("Tab 3"),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _fillTabs() {
    List<Widget> result;

    for (int i = 0; i < widget.tabs.length; i++) {
      result.add(Text(widget.tabs[i].text) as Widget);
    }

    return result;
  }
}
