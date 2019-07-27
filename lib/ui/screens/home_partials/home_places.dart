import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/screens/home_partials/home_categories.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

import '../place_detail.dart';

class HomePlaces extends StatefulWidget {
  List<DocumentSnapshot> documents;

  HomePlaces({Key key, this.documents}) : super(key: key);

  @override
  _HomePlacesState createState() => _HomePlacesState();
}

class _HomePlacesState extends State<HomePlaces> {
  TextEditingController controller;
  List<DocumentSnapshot> documents;
  List<QuerySnapshot> querySnapshot;

  @override
  void initState() {
    getData();
    print("Here is home_places.dart");
  }

  getData() {
    print("DATA IS GETTING: home_places.dart");
    return Firestore.instance
        .collection(Collection.Places)
        .where("isActive", isEqualTo: true)
        .where("isApproved", isEqualTo: true)
        .where("isDeleted", isEqualTo: false)
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            //Search
            SearchFormComponent(
              controller: controller,
              onPressed: () {},
            ),
            //End Search

            //Categories
            HomeCategories(),
            //End Categories

            //Product List
            /*Expanded(
              child: getPlaces(),
            ),*/
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: getData(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var documents = snapshot.data.documents;
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          //test(documents[index]);
                          return PlaceComponent(
                            documentID: documents[index].documentID,
                            title: documents[index]["name"],
                            rating: double.parse(documents[index]["rating"]),
                            image: documents[index]["images"][0],
                            properties: convertProperties(
                                documents[index]["properties"]),
                            isFav: documents[index].data["isFav"],
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
                },
              ),
            ),
            //Product List
          ],
        ),
      ),
      onRefresh: () {
        getData();
      },
    );
  }

  /*Widget getPlaces() {
    print("GETTIN LIST OF WIDGETS: home_places.dart");
    if (documents != null) {
      return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            //test(documents[index]);
            return PlaceComponent(
              documentID: documents[index].documentID,
              title: documents[index]["name"],
              rating: double.parse(documents[index]["rating"]),
              image: documents[index]["images"][0],
              properties: convertProperties(documents[index]["properties"]),
              isFav: documents[index].data["isFav"],
              onTap: () {
                redirecTo(
                    context,
                    PlaceDetail(
                      documentID: documents[index].documentID,
                      data: documents[index].data,
                    ));
              },
            );
          });
    } else {
      return Center(
        child: Text("İçerik bulunamadı."),
      );
    }
  }*/

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
