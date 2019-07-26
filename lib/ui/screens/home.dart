import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/bottom_nav_component.dart';
import 'package:cocukla/ui/components/category_component.dart';
import 'package:cocukla/ui/components/drawer_component.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/screens/place_detail.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home_explore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  FirebaseUser user;
  List<DocumentSnapshot> documents;
  static TextEditingController _homeSearchController;
  static TextEditingController _favSearchComponent;

  static List<PropertyComponent> attributes = [
    PropertyComponent(
        iconName: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(iconName: "location_on", content: "5.6km"),
    PropertyComponent(iconName: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(iconName: "child_friendly", content: "Bebek bakım odası"),
    PropertyComponent(iconName: "child_care", content: "Oyun odası")
  ];

  List<String> _titles = ["Çocukla", "Favorilerim", "Keşfet"];
  String _title = "Mekanlar";

  void setTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  List<Widget> _tabContents = [
    //HomeScreen
    SafeArea(
      child: Column(
        children: <Widget>[
          //Search
          SearchFormComponent(
            controller: _homeSearchController,
            onPressed: () {},
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
                GestureDetector(
                  child: Category(
                    imageUrl: "assets/images/place.png",
                    title: "Mekanlar",
                  ),
                  onTap: () {
                    //setTitle("Mekanlar");
                  },
                ),
                GestureDetector(
                  child: Category(
                    imageUrl: "assets/images/activity.png",
                    title: "Aktiviteler",
                  ),
                  onTap: () {
                    //setTitle("Aktiviteler");
                  },
                ),
                GestureDetector(
                    child: Category(
                      imageUrl: "assets/images/health.png",
                      title: "Sağlık",
                    ),
                    onTap: () {
                      //setTitle("Sağlık");
                    }),
                GestureDetector(
                    child: Category(
                      imageUrl: "assets/images/shopping.png",
                      title: "Alışveriş",
                    ),
                    onTap: () {
                      //setTitle("Alışveriş");
                    }),
              ],
            ),
          ),
          //End Categories

          //Product List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(Collection.Places)
                  .where("isActive", isEqualTo: true)
                  .where("isApproved", isEqualTo: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var doc = snapshot.data.documents[index];
                      return PlaceComponent(
                        documentID: doc.documentID,
                        title: doc["title"],
                        image: doc["images"][0],
                        isFav: doc["isFav"],
                        properties: doc["properties"], onTap: () {
                          redirecTo(context, PlaceDetail(
                            documentID: doc.documentID,
                            data: doc.data,
                          ));
                      },
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("İçerik bulunamadı."),
                  );
                }
              },
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
          SearchFormComponent(
            controller: _favSearchComponent,
            onPressed: () {},
          ),
          //End Search

          //Product List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                PlaceComponent(
                  documentID: "1",
                  title: "Fevzi Usta Köfte&Balık",
                  image: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 5,
                  properties: attributes,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title, style: AppStyle.AppBarTextStyle),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        drawer: DrawerComponent(
          user: user,
        ),
        body: _tabContents[_currentTab],
        bottomNavigationBar: BottomNavigationComponent(currentIndex: _currentTab, onTap: onTabTapped,),
      ),
    );
  }

  void getData({String category = "Mekanlar"}) {
    print("DATA IS GETTING...");
    Firestore.instance
        .collection(Collection.Places)
        .where("category", isEqualTo: category)
        .where("isDeleted", isEqualTo: false)
        .where("isApproved", isEqualTo: true)
        .getDocuments()
        .then((result) {
      if (result.documents.length > 0) {
        setState(() {
          documents = result.documents;
        });
        print("DOCUMENTS LENGTH: " + documents.length.toString());
        print("DOCUMENT ID: " + documents[0].documentID);
      }
    });
  }
}
