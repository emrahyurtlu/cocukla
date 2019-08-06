import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/business/user_service.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/ui/components/bottom_nav_component.dart';
import 'package:cocukla/ui/components/drawer_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _currentTab = 0;
  UserService _userService;

  //static List<DocumentSnapshot> documents;

  List<String> _titles = ["Çocukla", "Favorilerim", "Keşfet"];

  @override
  void initState() {
    consoleLog("HOME SCREEN");
    consoleLog("ACTIVE USER IS: ${AppData.user.toString()}");
    _userService = UserService();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      consoleLog("Firebase Messaging Token: $token");
      _userService.addMessagingToken(token, AppData.user.email);
    });

    if (AppData.user.name != AppData.firebaseUser.displayName) {
      _userService.updateName(AppData.firebaseUser.displayName, AppData.user.email);
      _userService.getUser(AppData.user.email).then((UserModel model) {
        setState(() {
          AppData.user = model;
        });
      });
    }
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
    redirectIfNotSignedIn(context);
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
            //user: AppData.user,
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
