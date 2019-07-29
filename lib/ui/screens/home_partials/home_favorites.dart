import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

import '../place_detail.dart';

class HomeFavorites extends StatefulWidget {
  @override
  _HomeFavoritesState createState() => _HomeFavoritesState();
}

class _HomeFavoritesState extends State<HomeFavorites> {
  TextEditingController controller;
  Future<QuerySnapshot> data;

  @override
  void initState() {
    data = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          //Search
          /*SearchFormComponent(
            controller: controller,
            onPressed: () {},
          ),*/
          //End Search
          SizedBox.fromSize(
            size: Size.fromHeight(5),
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
                          fav = List<String>.from(
                                  documents[index].data["favorites"])
                              .contains(AppData.user.email);
                          return PlaceComponent(
                            documentID: documents[index].documentID,
                            title: documents[index]["name"],
                            rating: double.parse(documents[index]["rating"]),
                            image: documents[index]["images"][0],
                            properties: convertProperties(
                                documents[index]["properties"]),
                            isFav: fav,
                            onTap: () {
                              redirecTo(
                                  context,
                                  PlaceDetail(
                                    documentID: documents[index].documentID,
                                    data: documents[index].data.cast(),
                                  ));
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
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text("İçerik bulunamadı."),
                  );
                }

                return Center(
                  child: Text("İçerik bulunamadı."),
                );
              },
            ),
          ),
          //Product List
        ],
      ),
    );
  }

  getData() {
    print("DATA IS GETTING: home_favorites.dart");
    return Firestore.instance
        .collection(Collections.Places)
        .where("isActive", isEqualTo: true)
        .where("isApproved", isEqualTo: true)
        .where("isDeleted", isEqualTo: false)
//        .where("favorites.${AppData.user.email}", isEqualTo: true)
        .where("favorites", arrayContains: AppData.user.email)
        .getDocuments();
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
