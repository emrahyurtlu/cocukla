import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/screens/place_form.dart';
import 'package:cocukla/ui/screens/waiting_to_approve.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controller;
  List<DocumentSnapshot> documents;

  @override
  void initState() {
    getData();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    redirectIfNotSignedIn(context);
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Mekanlarım", style: AppStyle.AppBarTextStyle),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: RefreshIndicator(
          child: Column(
            children: <Widget>[
              //Search
              SearchFormComponent(
                controller: _controller,
                labelText: "Mekanlarımda arayın",
                onPressed: () async {
                  var keyword = _controller.text?.trim();
                  processing(context);
                  getData(keyword);
                  Navigator.pop(context);
                },
                onChanged: (String text) {
                  if (text.length == 0) {
                    getData();
                  }
                },
              ),
              //End Search

              //Product List
              Expanded(
                child: getMyPlaces(),
              ),
            ],
          ),
          onRefresh: () async {
            print("MY PLACES PAGE IS REFRESHING.");
            getData();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceForm()),
            );
          },
        ),
      ),
    );
  }

  Widget getMyPlaces() {
    if (documents != null) {
      print("GETTIN LIST OF WIDGETS.");
      return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            var obj = PlaceModel.from(
                data: documents[index].data,
                documentID: documents[index].documentID);
            return PlaceComponent(
              documentID: documents[index].documentID,
              title: documents[index]["name"],
              rating: double.parse(documents[index]["rating"]),
              image: documents[index]["images"][0],
              properties: convertProperties(documents[index]["properties"]),
              isFav: documents[index].data["isFav"],
              onTap: () {
                if (obj.isApproved) {
                  redirectTo(
                      context,
                      PlaceForm(
                        documentID: documents[index].documentID,
                        data: documents[index].data,
                      ));
                } else {
                  redirectTo(
                      context,
                      WaitingToApprove(
                        documentID: obj.documentID,
                        data: obj.toJson(),
                      ));
                }
              },
              favoriteOnPressedCallback: () async {
                getData();
              },
            );
          });
    } else {
      return Column(
        children: <Widget>[
          //CircularProgressIndicator(),
          Center(
            child: Text("İçerik bulunamadı."),
          ),
        ],
      );
    }
  }

  Future<QuerySnapshot> getData([String keyword = ""]) async {
    print("DATA IS GETTING...");
    var result = await Firestore.instance
        .collection(Collections.Places)
        .where("owner", isEqualTo: AppData.user.email)
        .where("isDeleted", isEqualTo: false)
        .getDocuments();
    if (keyword.isNotEmpty) {
      if (result.documents.length > 0) {
        result.documents.removeWhere((doc) => !doc.data["name"]
            .toString()
            .toLowerCase()
            .contains(keyword.toLowerCase()));
      }
    }

    setState(() {
      documents = result.documents;
    });
    return result;
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