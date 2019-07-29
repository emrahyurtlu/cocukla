import 'package:cocukla/ui/components/bottom_nav_component.dart';
import 'package:cocukla/ui/components/drawer_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_partials/home_explore.dart';
import 'home_partials/home_favorites.dart';
import 'home_partials/home_places.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  FirebaseUser user;

  //static List<DocumentSnapshot> documents;

  List<String> _titles = ["Çocukla", "Favorilerim", "Keşfet"];

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      print("-----------------------------------------");
      print("HOME");
      print(user.toString());
      print("-----------------------------------------");
      if (user != null && user.email != null) {
        AppData.user = user;
        setState(() {
          this.user = user;
        });
      } else {
        Navigator.of(context).pushNamed(CustomRoute.signIn);
      }
    });
  }

  List<Widget> _tabContents = [
    //HomeScreen
    HomePlaces(),

    //Favorites
    HomeFavorites(),

    //Explore
    HomeExplore()
    //Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var title =
        _currentTab == 0 ? AppData.homeSelectedCategory : _titles[_currentTab];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: AppStyle.AppBarTextStyle),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        drawer: DrawerComponent(
          user: user,
        ),
        body: _tabContents[_currentTab],
        bottomNavigationBar: BottomNavigationComponent(
          currentIndex: _currentTab,
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
