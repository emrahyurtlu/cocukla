import 'dart:core';

import 'package:flutter/material.dart';

class SmartTab extends StatefulWidget {
  final List<Tab> tabs;
  final List<Page> pages;

  SmartTab({@required this.tabs, @required this.pages})
      : assert(tabs.isNotEmpty, "Tab length is equal to 0"),
        assert(pages.isNotEmpty, "Tab content length is equal to 0"),
        assert(tabs.length == pages.length,
            "Tab count and content count must be the same");

  @override
  _SmartTabState createState() => _SmartTabState();
}

class _SmartTabState extends State<SmartTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: widget.tabs,
          key: GlobalKey(),
          labelPadding: EdgeInsets.only(left: 5, right: 5),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: TabBarView(
              controller: _tabController,
              children: widget.pages,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class Page extends StatelessWidget {
  final Widget child;

  Page({this.child});

  @override
  Widget build(BuildContext context) {
    return this.child;
  }
}
