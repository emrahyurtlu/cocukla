import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/components/category_component.dart';
import 'package:cocukla/components/place_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/screens/home_explore.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/route.dart';
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
  FirebaseUser user;

  static List<PropertyComponent> attributes = [
    PropertyComponent(
        iconName: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(iconName: "location_on", content: "5.6km"),
    PropertyComponent(iconName: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(iconName: "child_friendly", content: "Bebek bakım odası"),
    PropertyComponent(iconName: "child_care", content: "Oyun odası")
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
                            Icons.search,
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
                        id: doc.documentID,
                        title: doc["title"],
                        image: doc["images"][0],
                        isFav: doc["isFav"],
                        properties: doc["properties"],
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
                PlaceComponent(
                  id: "1",
                  title: "Fevzi Usta Köfte&Balık",
                  image: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 5,
                  properties: attributes,
                  isFav: true,
                ),
                PlaceComponent(
                  id: "2",
                  title: "Kaşıbeyaz Ataşehir",
                  image: "assets/images/temp/kasibeyaz_atasehir.jpg",
                  rating: 3,
                  properties: attributes,
                  isFav: true,
                ),
                PlaceComponent(
                  id: "3",
                  title: "Trilye Restaurant",
                  image: "assets/images/temp/fevzi_usta.jpeg",
                  rating: 4.5,
                  properties: attributes,
                  isFav: true,
                ),
                PlaceComponent(
                  id: "4",
                  title: "Mado Bahçelievler",
                  image: "assets/images/temp/mado.jpg",
                  rating: 3,
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
                accountName: Text(
                  (user != null &&
                          user.displayName != null &&
                          user.displayName != "")
                      ? user.displayName
                      : "Kullanıcı",
                  style: TextStyle(color: AppColor.white),
                ),
                accountEmail: Text(user != null ? user.email : "",
                    style: TextStyle(color: AppColor.white)),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                      child: CachedNetworkImage(
                    imageUrl: user != null && user.photoUrl != null
                        ? user.photoUrl
                        : "assets/images/user.png",
                    width: 86,
                    height: 86,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
                  radius: 50,
                  backgroundColor: AppColor.light_gray,
                ),
                decoration: BoxDecoration(color: AppColor.pink),
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text("Profilim"),
                onTap: () {
                  Navigator.of(context).pushNamed("/my-profile");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.place),
                title: Text("Mekanlarım"),
                onTap: () {
                  Navigator.of(context).pushNamed("/my-places");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Çıkış"),
                onTap: () {
                  if (AppData.user != null) logoutLog(AppData.user.email);
                  FirebaseAuth.instance.signOut().then((_) {
                    AppData.user = null;
                    Navigator.of(context).pushNamed("/sign-in");
                  });
                },
              ),
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
