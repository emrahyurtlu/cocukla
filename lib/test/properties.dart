import 'package:flutter/material.dart';

class PropertyTest extends StatefulWidget {
  @override
  _PropertyTestState createState() => _PropertyTestState();
}

class _PropertyTestState extends State<PropertyTest> {
  List<Map<String, dynamic>> props = [
    {
      "content": "Çocuk menüsü",
      "icon": "restaurant_menu",
      "order": "1",
      "isActive": true
    },
    {
      "content": "Çocuk oyun alanı",
      "icon": "category",
      "order": "2",
      "isActive": true
    },
    {
      "content": "Oyun ablası",
      "icon": "remove_red_eye",
      "order": "3",
      "isActive": true
    },
    {
      "content": "Çocuk atölyesi",
      "icon": "color_lens",
      "order": "4",
      "isActive": true
    },
    {"content": "Çocuk tuvaleti", "icon": "wc", "order": "5", "isActive": true},
    {
      "content": "Çocuk masa ve sandalyesi ",
      "icon": "event_seat",
      "order": "6",
      "isActive": true
    },
    {
      "content": "Bebek bakım odası",
      "icon": "child_care",
      "order": "7",
      "isActive": true
    },
    {
      "content": "Özel gün organizasyonu yapılır",
      "icon": "cake",
      "order": "8",
      "isActive": true
    },
    {
      "content": "Randevu ile gidilir ",
      "icon": "calendar_today",
      "order": "9",
      "isActive": true
    },
    {
      "content": "Alkol tüketilir ",
      "icon": "local_bar",
      "order": "10",
      "isActive": true
    },
    {
      "content": "Toplantı organizasyonu",
      "icon": "work",
      "order": "11",
      "isActive": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Import Properties"),
            onPressed: () async {
              /*for (var item in props) {
                Firestore.instance
                    .collection(Collection.Properties)
                    .add(item)
                    .catchError((e) => print("IMPORT ERROR: " + e));
              }*/
            },
          ),
        ),
      ),
    );
  }
}
