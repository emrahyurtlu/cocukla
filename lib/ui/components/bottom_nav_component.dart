import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';

class BottomNavigationComponent extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavigationComponent(
      {Key key, @required this.onTap, @required this.currentIndex})
      : super(key: key);

  @override
  _BottomNavigationComponentState createState() =>
      _BottomNavigationComponentState();
}

class _BottomNavigationComponentState extends State<BottomNavigationComponent> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      unselectedItemColor: AppColor.dark_gray,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Anasayfa'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          title: Text('Favorilerim'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.explore), title: Text('Keşfet')),
      ],
      backgroundColor: AppColor.white,
      selectedItemColor: AppColor.pink,
    );
  }
}
