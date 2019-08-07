import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/screens/place_form.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

class Approval extends StatefulWidget {
  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
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
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Onay Bekleyenler", style: AppStyle.AppBarTextStyle),
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
                labelText: "Onay bekleyenlerde arayın",
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
            print("PENDING APPROVAL PAGE IS REFRESHING.");
            await getData();
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
            //test(documents[index]);
            return PlaceComponent(
              documentID: documents[index].documentID,
              title: documents[index]["name"],
              rating: double.parse(documents[index]["rating"]),
              image: documents[index]["images"][0],
              properties: convertProperties(documents[index]["properties"]),
              isFav: documents[index].data["isFav"],
              onTap: () {
                redirectTo(
                    context,
                    PlaceForm(
                      documentID: documents[index].documentID,
                      data: documents[index].data,
                    ));
              },
              favoriteOnPressedCallback: () async {
                getData();
              },
            );
          });
    } else {
      return Center(
        child: Text("İçerik bulunamadı."),
      );
    }
  }

  Future<QuerySnapshot> getData([String keyword = ""]) async {
    print("DATA IS GETTING...");
    var result = await Firestore.instance
        .collection(Collections.Places)
        .where("isApproved", isEqualTo: false)
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
