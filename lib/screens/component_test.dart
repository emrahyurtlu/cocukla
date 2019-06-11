import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComponentTest extends StatelessWidget {

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
          child: FlatButton(child: Text("Menü içeriği burada yer alacak!"),),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                border: Border.all(color: Colors.white),
                color: AppColor.white),
            child: ListView(
              children: <Widget>[

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            fixedColor: AppColor.text_color,
            unselectedItemColor: AppColor.dark_gray,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title:Text('Anasayfa'),
                backgroundColor: AppColor.white
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                title: Text('Favorilerim'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  title: Text('Keşfet')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('Profilim')
              )
            ],
          backgroundColor: AppColor.white,
        ),
      ),
    );
  }
}
