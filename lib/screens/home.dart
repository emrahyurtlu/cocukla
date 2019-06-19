import 'package:cocukla/components/attribute.dart';
import 'package:cocukla/components/category.dart';
import 'package:cocukla/components/product.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/utilities/dimension_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static BuildContext _context;
  BuildContext context2;
  int _currentTab = 0;
  static List<Attribute> attributes = [
    Attribute(Icons.access_time, "Açık", AppColor.green),
    Attribute(Icons.location_on, "5.6km"),
    Attribute(Icons.restaurant_menu, "Çocuk menüsü"),
    Attribute(Icons.child_friendly, "Bebek bakım odası"),
    Attribute(Icons.child_care, "Oyun odası")
  ];

  final List<Widget> _tabContents = [
    //HomeScreen print
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

          Container(
            width: double.infinity,
            height: 460,
            child: ListView(
              padding: EdgeInsets.all(0),
              controller: null,
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
              ],
            ),
          ),

          //Product List
        ],
      ),
    ),
    Text("Favorilerim 1"),
    Text("Favorilerim 2"),
    Text("Keşfet"),
    //Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      _context = context;
      context2 = context;
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mekanlar",
              style: TextStyle(
                  color: AppColor.text_color, fontFamily: "MontserratRegular")),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        drawer: Drawer(
          child: Text("Menü içeriği burada yer alacak!"),
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
            /*BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profilim')
            )*/
          ],
          backgroundColor: AppColor.white,
          selectedItemColor: AppColor.pink,
        ),
      ),
    );
  }
}
