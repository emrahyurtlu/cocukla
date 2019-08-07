import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/user_service.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/ui/components/conditional_component.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../place_detail.dart';

class HomeFavorites extends StatefulWidget {
  @override
  _HomeFavoritesState createState() => _HomeFavoritesState();
}

class _HomeFavoritesState extends State<HomeFavorites> {
  TextEditingController controller;
  Future<QuerySnapshot> data;
  List<PlaceModel> favorites;

  @override
  void initState() {
    consoleLog("Initiated of user favorites is fired!");
    getData().then((List<PlaceModel> result) {
      favorites = result;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return SafeArea(
      child: RefreshIndicator(
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
            ConditionalComponent(
              condition: favorites != null && favorites.length > 0,
              child: Expanded(
                child: ListView.builder(
                    itemCount: favorites?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var favorite = favorites[index];
                      return PlaceComponent(
                        documentID: favorite.documentID,
                        title: favorite.name,
                        rating: double.parse(favorite.rating),
                        image: favorite.images.first,
                        properties: convertProperties(favorite.properties),
                        isFav: true,
                        onTap: () {
                          redirectTo(
                              context,
                              PlaceDetail(
                                documentID: favorite.documentID,
                                data: favorite.toJson(),
                              ));
                        },
                        favoriteOnPressedCallback: () async {
                          await getData();
                        },
                      );
                    }),
              ),
              otherWise: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("İçerik bulunamadı."),
                ],
              ),
            ),
            //Product List
          ],
        ),
        onRefresh: () async {
          await getData();
        },
      ),
    );
  }

  Future<List<PlaceModel>> getData() async {
    print("DATA IS GETTING: home_favorites.dart");
    var _userService = UserService();
    var result = await _userService.getFavorites(AppData.user.favorites);
    consoleLog("getData() result: ${result.toString()}");
    setState(() {
      favorites = result;
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
