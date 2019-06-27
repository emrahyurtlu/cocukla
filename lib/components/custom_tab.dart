import 'dart:core';

import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {
  TabController controller;
  List<Tab> tabs;
  List<Widget> content;

  CustomTab({this.controller, @required this.tabs, @required this.content})
      : assert(tabs.isNotEmpty, "Tab length is equal to 0"),
        assert(content.isNotEmpty, "Tab content length is equal to 0"),
        assert(tabs.length == content.length,
            "Tab count and content count must be the same");

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  int _index;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKey(),
      child: Column(
        key: GlobalKey(),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //HeaderSection
          Row(
              key: GlobalKey(),
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _createTabs()),
          //Content Section
          Row(
            key: GlobalKey(),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child: widget.content.elementAt(_index),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _createTabs() {
    List<Widget> result = [];
    var activeTabBorder = Border(
      bottom: BorderSide(width: 1, color: AppColor.text_color),
    );

    for (int i = 0; i < widget.tabs.length; i++) {
      Widget temp = GestureDetector(
        key: GlobalKey(),
        child: DecoratedBox(
          key: GlobalKey(),
          decoration:
              BoxDecoration(border: _index == i ? activeTabBorder : null),
          child: Padding(
            key: GlobalKey(),
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
            child: Text(widget.tabs[i].text,
                key: GlobalKey(),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        onTap: () => saveState(i),
      );
      result.add(temp);
    }

    return result;
  }

  void saveState(int i) {
    setState(() {
      this._index = i;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
