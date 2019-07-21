import 'package:cocukla/business/helpers/current_user.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/components/category_component.dart';
import 'package:cocukla/components/product_component.dart';
import 'package:cocukla/components/property_component.dart';
import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/photo_model.dart';
import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/models/property_model.dart';
import 'package:cocukla/screens/home_explore.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
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

  var model = ProductModel(
      id: "1",
      title: "Kaşıbeyaz Ataşehir",
      city: "İstanbul",
      district: "Ataşehir",
      editor_id: "1",
      isFav: true,
      phone_number: "02122252244",
      rating: 4,
      email: "atasehir@kasiyeyaz.com",
      fax: "02125554411",
      text:
          "Kaşıbeyaz restaurant 1980 yılında Gaziantep'te kurulmuştur. Kurulduğu günden beri kaliteden ödün vermeden hizmet sektöründe iş yaşamına devam etmiştir.",
      address: "Yeşiltepe Mah. Konyalı Sok. No:24 Ataşehir/İstanbul",
      comments: [
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Abdullah O.",
            rating: 4,
            text:
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            date: DateTime.now()),
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Mehmet S.",
            rating: 5,
            text:
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
            date: DateTime.now()),
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Bayram T.",
            rating: 3,
            text:
                "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            date: DateTime.now()),
        CommentModel(
            imageLink: "assets/images/avatar.png",
            name: "Emrah Y.",
            rating: 5,
            text:
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            date: DateTime.now()),
      ],
      photos: [
        PhotoModel(imageLink: "assets/images/temp/kasibeyaz_atasehir.jpg"),
        PhotoModel(imageLink: "assets/images/temp/gha_3325.jpg"),
        PhotoModel(imageLink: "assets/images/temp/gha_3336.jpg"),
        PhotoModel(imageLink: "assets/images/temp/gha_3499.jpg"),
        PhotoModel(imageLink: "assets/images/temp/gha_3612.jpg"),
      ],
      properties: [
        PropertyModel(
            icon_name: "access_time",
            text: "10:00-00:00 arası hizmet vermektedir",
            color: AppColor.green),
        PropertyModel(
            icon_name: "location_on", text: "5.6km", color: AppColor.dark_gray),
        PropertyModel(
            icon_name: "restaurant_menu",
            text: "Çocuk menüsü",
            color: AppColor.dark_gray),
        PropertyModel(
            icon_name: "child_friendly",
            text: "Bebek bakım odası",
            color: AppColor.dark_gray),
        PropertyModel(
            icon_name: "child_care",
            text: "Oyun odası",
            color: AppColor.dark_gray),
        PropertyModel(
            icon_name: "calendar_today",
            text: "Randevu ile gidilir",
            color: AppColor.dark_gray),
        PropertyModel(
            icon_name: "cake",
            text: "Organizasyon yapılır",
            color: AppColor.dark_gray),
      ]);

  static List<PropertyComponent> attributes = [
    PropertyComponent(
        icon_name: "access_time", content: "Açık", color: AppColor.green),
    PropertyComponent(icon_name: "location_on", content: "5.6km"),
    PropertyComponent(icon_name: "restaurant_menu", content: "Çocuk menüsü"),
    PropertyComponent(
        icon_name: "child_friendly", content: "Bebek bakım odası"),
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
    _currentUserHelper.getCurrentUser().then((FirebaseUser result) {
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
                accountName: Text(
                  AppData.user["name"],
                  style: TextStyle(color: AppColor.white),
                ),
                accountEmail: Text(AppData.user["email"],
                    style: TextStyle(color: AppColor.white)),
                currentAccountPicture: Image.asset(
                  "assets/images/avatar.png",
                  width: 86,
                  height: 86,
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
                  logoutLog(AppData.user["email"]);
                  AppData.user = null;
                  Navigator.of(context).pushNamed("/sign-in");
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
