import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/screens/place_form.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';

class Approval extends StatefulWidget {
  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  TextEditingController _controller;
  List<DocumentSnapshot> documents;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    redirectIfNotSignedIn(context);
    return SafeArea(
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
                labelText: "Onay bekleyen arayın",
                onPressed: () {},
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
            getData();
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
              }, favoriteOnPressedCallback: () async {
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

  void getData() {
    print("DATA IS GETTING...");
    Firestore.instance
        .collection(Collections.Places)
        .where("isApproved", isEqualTo: false)
        .getDocuments()
        .then((result) {
      if (result.documents.length > 0) {
        setState(() {
          documents = result.documents;
        });
        print("DOCUMENTS LENGTH: " + documents.length.toString());
        print("DOCUMENT SAMPLE: " + documents[0].data.toString());
      }
    });
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
