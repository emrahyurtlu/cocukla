import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/header_component.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/font_family.dart';
import 'package:cocukla/ui/screens/home_partials/home_categories.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

import '../place_detail.dart';

class HomePlaces extends StatefulWidget {
  @override
  _HomePlacesState createState() => _HomePlacesState();
}

class _HomePlacesState extends State<HomePlaces> {
  TextEditingController _controller;
  Future<QuerySnapshot> data;

  @override
  void initState() {
    data = getData();
    print("Here is home_places.dart");
    _controller = TextEditingController();
    super.initState();
  }

  Future<QuerySnapshot> getData([String keyword = ""]) async {
    print("DATA IS GETTING: home_places.dart");
    Future<QuerySnapshot> result;
    result = Firestore.instance
        .collection(Collections.Places)
        .where("isActive", isEqualTo: true)
        .where("isApproved", isEqualTo: true)
        .where("isDeleted", isEqualTo: false)
        .where("category", isEqualTo: AppData.homeSelectedCategory)
        .orderBy("updateDate", descending: true)
        .getDocuments();

    if (keyword.isNotEmpty) {
      result.then((QuerySnapshot snapshot) {
        if (snapshot.documents.length > 0) {
          snapshot.documents.removeWhere((doc) => !doc.data["name"]
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()));
        }
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            data = getData();
          });
        },
        child: Column(
          children: <Widget>[
            //Search
            SearchFormComponent(
              controller: _controller,
              labelText: "Ara: ${AppData.homeSelectedCategory}",
              onPressed: () async {
                var keyword = _controller.text.trim();
                setState(() {
                  processing(context);
                  data = getData(keyword);
                  Navigator.pop(context);
                });
              },
              onChanged: (String text) {
                if (text.length == 0) {
                  data = getData();
                }
              },
            ),
            //End Search
            Row(
              children: <Widget>[
                HeaderComponent(
                  "Kategoriler",
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  showDivider: false,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.MontserratLight),
                  padding: EdgeInsets.only(top: 10, bottom: 0, left: 10),
                ),
              ],
            ),
            //Categories
            HomeCategories(
              onCategoryTap: () async {
                setState(() {
                  data = getData();
                });
              },
            ),
            //End Categories

            Row(
              children: <Widget>[
                HeaderComponent(
                  AppData.homeSelectedCategory,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  showDivider: false,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.MontserratLight),
                  padding: EdgeInsets.only(top: 10, bottom: 0, left: 10),
                ),
              ],
            ),
            //Product List
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: data,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var documents = snapshot.data.documents;
                      bool fav = false;
                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            fav = AppData.user.favorites
                                .contains(documents[index].documentID);
                            return PlaceComponent(
                              documentID: documents[index].documentID,
                              title: documents[index]["name"],
                              rating: double.parse(documents[index]["rating"]),
                              image: documents[index]["images"][0],
                              properties: convertProperties(
                                  documents[index]["properties"]),
                              isFav: fav,
                              onTap: () {
                                redirectTo(
                                    context,
                                    PlaceDetail(
                                      documentID: documents[index].documentID,
                                      data: documents[index].data.cast(),
                                    ));
                              },
                              favoriteOnPressedCallback: () async {
                                await getData();
                              },
                            );
                          });
                    } else {
                      return Center(
                        child: Text("İçerik bulunamadı."),
                      );
                    }
                  } else if (snapshot.connectionState ==
                          ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    return Center(
                      child: CircularProgressIndicator(),
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
    );
  }

  List<PropertyComponent> convertProperties(List properties) {
    var result = List<PropertyComponent>();

    if (properties.length > 0) {
      properties.forEach((item) {
        var temp = PropertyComponent(
            iconName: item["iconName"], content: item["content"]);
        result.add(temp);
      });
    }
    return result;
  }
}
