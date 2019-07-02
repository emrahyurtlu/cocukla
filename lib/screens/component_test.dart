import 'package:cocukla/components/smart_tab.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SmartTab(
            tabs: <Tab>[
              Tab(
                text: "Özellikler",
              ),
              Tab(
                text: "Fotoğraflar",
              ),
              Tab(
                text: "Yorumlar",
              ),
              Tab(
                text: "Hakkımızda",
              ),
            ],
            pages: <Page>[
              Page(
                child: Text("Page 1"),
              ),
              Page(
                child: Text("Page 2"),
              ),
              Page(
                child: Text("Page 3"),
              ),
              Page(
                child: Text("Page 4"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
