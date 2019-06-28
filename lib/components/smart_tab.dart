import 'dart:core';

import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class SmartTab extends StatefulWidget {
  TabController controller;
  List<Tab> tabs;
  List<Widget> content;

  SmartTab({this.controller, @required this.tabs, @required this.content})
      : assert(tabs.isNotEmpty, "Tab length is equal to 0"),
        assert(content.isNotEmpty, "Tab content length is equal to 0"),
        assert(tabs.length == content.length,
            "Tab count and content count must be the same");

  @override
  _SmartTabState createState() => _SmartTabState();
}

class _SmartTabState extends State<SmartTab>
    with SingleTickerProviderStateMixin {
  int _index;
  Offset initial;
  Offset latest;

  @override
  void initState() {
    super.initState();
    _index = 0;
    initial = latest = Offset(0, 0);
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
              Expanded(
                child: IntrinsicHeight(
                  key: GlobalKey(),
                  child: GestureDetector(
                      key: GlobalKey(),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        padding: EdgeInsets.only(top: 10),
                        child: widget.content.elementAt(_index),
                      ),
                      onHorizontalDragStart: (DragStartDetails start) => {
                            initial = start.globalPosition,
                          },
                      onHorizontalDragUpdate: (DragUpdateDetails update) =>
                          {latest = update.globalPosition},
                      onHorizontalDragEnd: (DragEndDetails end) => {
                            print("Initial: " + this.initial.toString()),
                            print("Latest: " + this.latest.toString()),
                            if (this.latest.dx - this.initial.dx > 0)
                              {
                                //print("Sağa doğru hareket")
                                this.saveState(
                                    (_index + 1) % widget.content.length)
                              }
                            else
                              {
                                //print("Sola doğru hareket")
                                this.saveState(
                                    (_index - 1) % widget.content.length)
                              }
                          }),
                ),
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
    super.dispose();
  }
}
