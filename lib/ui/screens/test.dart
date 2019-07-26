import 'dart:core';

import 'package:cocukla/datalayer/data_layer.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/utilities/device_location.dart';
import 'package:flutter/material.dart';

class ComponentTest extends StatefulWidget {
  @override
  _ComponentTestState createState() => _ComponentTestState();
}

class _ComponentTestState extends State<ComponentTest> {
  /*LatLng _center;

  Position currentLocation;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });

    print('center $_center');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Text("Hello World!!"),
        ),
      ),
    );
  }*/
  DataLayer _service = DataLayer();
  Map<String, dynamic> insert = {"name": "Ali"};
  Map<String, dynamic> update = {"name": "Veli"};
  UserModel model;

  @override
  Widget build(BuildContext context) {
    String label = "Get Device Location";
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text("Get Device Location"),
              onPressed: () async {
                var location = await getLocation();
                print("Your latitude is: " + location.latitude.toString());
                print("Your longitude is: " + location.longitude.toString());

                var cityName = await getCityName();
                print("City name: " + cityName);

                var districtName = await getDistrictName();
                print("District name: " + districtName);
              },
            ),
          )
          /*RaisedButton(
            child: Text("INSERT"),
            onPressed: () {
              _service.insert(Collection.Users, insert);
            },
          ),
          RaisedButton(
            child: Text("UPDATE"),
            onPressed: () {
              _service.update(Collection.Users, update, "-LkAcf3iIJg2hl696gl4");
            },
          ),
          RaisedButton(
            child: Text("DELETE"),
            onPressed: () {
              _service.delete(Collection.Users, "-LkAkpv_38vyk7rgkIXy");
            },
          ),
          RaisedButton(
            child: Text("GET"),
            onPressed: () {
              _service.get(Collection.Users, "-LkAkpv_38vyk7rgkIXy").then(
                  (onValue) =>
                      print("Data is retrived! " + onValue.data["name"]));
            },
          ),
          RaisedButton(
            child: Text("GET LIST"),
            onPressed: () {
              _service.getList(Collection.Users).then((onValue) => print(
                  "Data is retrived as list! " + onValue.documents[3]["name"]));
            },
          ),*/
        ],
      )),
    );
  }
}
