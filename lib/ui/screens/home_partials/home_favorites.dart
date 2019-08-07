import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/user_service.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/ui/components/conditional_component.dart';
import 'package:cocukla/ui/components/place_component.dart';
import 'package:cocukla/ui/components/property_component.dart';
import 'package:cocukla/ui/components/search_form.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/console_message.dart';
import 'package:cocukla/utilities/processing.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../place_detail.dart';

class HomeFavorites extends StatefulWidget {
  @override
  _HomeFavoritesState createState() => _HomeFavoritesState();
}

class _HomeFavoritesState extends State<HomeFavorites> {
  TextEditingController _controller;
  List<PlaceModel> favorites;

  @override
  void initState() {
    consoleLog("Initiated of user favorites is fired!");
    getData().then((List<PlaceModel> result) {
      favorites = result;
    });
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        child: Column(
          children: <Widget>[
            //Search
            SearchFormComponent(
              controller: _controller,
              labelText: "Favorilerde arayın",
              onPressed: () async {
                var keyword = _controller.text?.trim();
                processing(context);
                var temp = await getData(keyword);
                setState(() {
                  favorites = temp;
                });
                Navigator.pop(context);
              },
              onChanged: (String text){
                if(text.length == 0){
                  getData().then((list){
                    favorites = list;
                  });
                }
              },
            ),
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

  Future<List<PlaceModel>> getData([String keyword = ""]) async {
    print("DATA IS GETTING: home_favorites.dart");
    var _userService = UserService();
    var filtered = List<PlaceModel>();
    var result = await _userService.getFavorites(AppData.user.favorites);

    if (keyword.isNotEmpty) result.forEach((place) {
      if (place.name.toLowerCase().contains(keyword.toLowerCase()))
        filtered.add(place);

      result = filtered;
    });
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
