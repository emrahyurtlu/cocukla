import 'package:cocukla/components/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: CustomTab(
            tabs: <Tab>[
              Tab(text: "Özellikler",),
              Tab(text: "Fotoğraflar",),
              Tab(text: "Yorumlar",),
              Tab(text: "Hakkımızda",),
            ],
            content: <Widget>[
              Text("Page 1"),
              Text("Page 2"),
              Text("Page 3"),
              Text("Page 4"),
            ],
          ),

        ),
      ),
    );
  }
}
