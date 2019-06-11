import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;

  final List<Widget> _tabContents = [
    //HomeScreen
    SafeArea(
      child: Container(
        width: double.infinity,
        height: 70,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
            border: Border.all(color: Colors.white),
            color: AppColor.white),
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
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
                                              labelStyle: TextStyle(
                                                  color: AppColor.text_color),
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
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
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
            Container(
              width: 300,
              height: 87,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  border: Border.all(color: Colors.white),
                  color: AppColor.white),
              child: Row(
                children: <Widget>[
                  Text("Kategori 1"),
                  Text("Kategori 2"),
                  Text("Kategori 3"),
                  Text("Kategori 4"),
                ],
              ),
            )
          ],
        ),
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
          //fixedColor: AppColor.pink,
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
