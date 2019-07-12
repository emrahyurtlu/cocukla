import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/components/category_component.dart';
import 'package:cocukla/components/product_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/screens/home_explore.dart';
import 'package:cocukla/services/helpers/current_user.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  CurrentUserHelper _currentUserHelper;
  FirebaseUser user;


  static List<PropertyComponent> attributes = [
    PropertyComponent(icon_name: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(icon_name: "location_on", content: "5.6km"),
    PropertyComponent(icon_name: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(icon_name: "child_friendly", content: "Bebek bakım odası"),
    PropertyComponent(icon_name: "child_care", content: "Oyun odası")
  ];

  List<String> _titles = ["Çocukla", "Favorilerim", "Keşfet"];



  List<Widget> _tabContents = [
    //HomeScreen
    SafeArea(
      child: Column(
        children: <Widget>[
          //Search
          Container(
            width: double.infinity,
            height: 70,
            margin: EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                border: Border.all(color: Colors.white),
                color: AppColor.white),
            child: Row(
              children: <Widget>[
                Form(
                  key: GlobalKey(),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 280,
                        height: 48,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 0, top: 0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColor.light_gray,
                                ),
                                child: TextFormField(
                                  controller: null,
                                  keyboardType: TextInputType.text,
                                  decoration: new InputDecoration(
                                    labelStyle:
                                        TextStyle(color: AppColor.text_color),
                                    labelText: "Mekan arayın",
                                    //hintText: "Ara",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 25, top: 5),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  width: 10,
                  height: 40,
                ),
                SizedBox(
                    width: 60,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.pink,
                      ),
                      child: Container(
                        width: 60,
                        height: 40,
                        child: FlatButton(
                          color: AppColor.pink,
                          textColor: AppColor.white,
                          onPressed: () => {print("From Filter Button")},
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0)),
                          child: Icon(
                            Icons.tune,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          //End Search

          //Categories
          Container(
            width: double.infinity,
            height: 90,
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                border: Border.all(color: Colors.white),
                color: AppColor.white),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Category(
                  imageUrl: "assets/images/place.png",
                  title: "Mekanlar",
                ),
                Category(
                  imageUrl: "assets/images/activity.png",
                  title: "Aktiviteler",
                ),
                Category(
                  imageUrl: "assets/images/health.png",
                  title: "Sağlık",
                ),
                Category(
                  imageUrl: "assets/images/shopping.png",
                  title: "Alışveriş",
                ),
                Category(
                  imageUrl: "assets/images/place.png",
                  title: "Mekanlar",
                ),
                Category(
                  imageUrl: "assets/images/activity.png",
                  title: "Aktiviteler",
                ),
                Category(
                  imageUrl: "assets/images/health.png",
                  title: "Sağlık",
                ),
                Category(
                  imageUrl: "assets/images/shopping.png",
                  title: "Alışveriş",
                ),
              ],
            ),
          ),
          //End Categories

          //Product List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Product(
                  id: 1,
                  title: "Fevzi Usta Köfte&Balık",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 5,
                  attributes: attributes,
                  isFav: true,
                ),
                Product(
                  id: 2,
                  title: "Kaşıbeyaz Ataşehir",
                  imageUrl: "assets/images/temp/kasibeyaz_atasehir.jpg",
                  rating: 3,
                  attributes: attributes,
                  isFav: false,
                ),
                Product(
                  id: 3,
                  title: "Trilye Restaurant",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 4.5,
                  attributes: attributes,
                  isFav: true,
                ),
                Product(
                  id: 4,
                  title: "Mado Bahçelievler",
                  imageUrl: "assets/images/temp/mado.jpg",
                  rating: 3,
                  attributes: attributes,
                  isFav: true,
                ),
                Product(
                  id: 5,
                  title: "Fevzi Usta Köfte&Balık",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 5,
                  attributes: attributes,
                  isFav: false,
                ),
                Product(
                  id: 6,
                  title: "Fevzi Usta Köfte&Balık",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 2,
                  attributes: attributes,
                  isFav: false,
                ),
                Product(
                  id: 7,
                  title: "Kaşıbeyaz Ataşehir",
                  imageUrl: "assets/images/temp/kasibeyaz_atasehir.jpg",
                  rating: 4,
                  attributes: attributes,
                  isFav: false,
                ),
                Product(
                  id: 8,
                  title: "Trilye Restaurant",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 1.5,
                  attributes: attributes,
                  isFav: false,
                ),
                Product(
                  id: 9,
                  title: "Mado Bahçelievler",
                  imageUrl: "assets/images/temp/mado.jpg",
                  rating: 5,
                  attributes: attributes,
                  isFav: false,
                ),
                Product(
                  id: 10,
                  title: "Fevzi Usta Köfte&Balık",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 0.5,
                  attributes: attributes,
                  isFav: false,
                ),
              ],
            ),
          ),
          //Product List
        ],
      ),
    ),

    //Favorites
    SafeArea(
      child: Column(
        children: <Widget>[
          //Search
          Container(
            width: double.infinity,
            height: 70,
            margin: EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                border: Border.all(color: Colors.white),
                color: AppColor.white),
            child: Row(
              children: <Widget>[
                Form(
                  key: GlobalKey(),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 280,
                        height: 48,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 0, top: 0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColor.light_gray,
                                ),
                                child: TextFormField(
                                  controller: null,
                                  keyboardType: TextInputType.text,
                                  decoration: new InputDecoration(
                                    labelStyle:
                                        TextStyle(color: AppColor.text_color),
                                    labelText: "Mekan arayın",
                                    //hintText: "Ara",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 25, top: 5),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  width: 10,
                  height: 40,
                ),
                SizedBox(
                    width: 60,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.pink,
                      ),
                      child: Container(
                        width: 60,
                        height: 40,
                        child: FlatButton(
                          color: AppColor.pink,
                          textColor: AppColor.white,
                          onPressed: () => {print("From Filter Button")},
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0)),
                          child: Icon(
                            Icons.tune,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          //End Search

          //Product List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Product(
                  id: 1,
                  title: "Fevzi Usta Köfte&Balık",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 5,
                  attributes: attributes,
                  isFav: true,
                ),
                Product(
                  id: 2,
                  title: "Kaşıbeyaz Ataşehir",
                  imageUrl: "assets/images/temp/kasibeyaz_atasehir.jpg",
                  rating: 3,
                  attributes: attributes,
                  isFav: true,
                ),
                Product(
                  id: 3,
                  title: "Trilye Restaurant",
                  imageUrl: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 4.5,
                  attributes: attributes,
                  isFav: true,
                ),
                Product(
                  id: 4,
                  title: "Mado Bahçelievler",
                  imageUrl: "assets/images/temp/mado.jpg",
                  rating: 3,
                  attributes: attributes,
                  isFav: true,
                ),
              ],
            ),
          ),
          //Product List
        ],
      ),
    ),

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
  void initState() {
    _currentUserHelper = CurrentUserHelper();
    _currentUserHelper.getCurrentUser().then((FirebaseUser result){
      user = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_currentTab],
              style: TextStyle(
                  color: AppColor.text_color, fontFamily: "MontserratRegular")),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        drawer: Drawer(
          child: ListView(
              padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Emrah YURTLU",style: TextStyle(color: AppColor.white),),
                accountEmail: Text("emrahyurtlu@gmail.com", style: TextStyle(color: AppColor.white)),
                currentAccountPicture: Image.asset(
                  "assets/images/avatar.png",
                  width: 86,
                  height: 86,
                ),
                decoration: BoxDecoration(color: AppColor.pink),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Çıkış"),
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamed("/sign-in");
                },
              )
            ],
          ),
        ),
        body: _tabContents[_currentTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          unselectedItemColor: AppColor.dark_gray,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          onTap: onTabTapped,
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
        ),
      ),
    );
  }
}
