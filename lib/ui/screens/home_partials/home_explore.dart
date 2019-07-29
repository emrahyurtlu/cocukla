import 'package:cocukla/utilities/app_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeExplore extends StatefulWidget {
  @override
  _HomeExploreState createState() => _HomeExploreState();
}

class _HomeExploreState extends State<HomeExplore> {
  List<Marker> allMarkers = [];
  Position currentLocation;
  GoogleMapController controller;
  BitmapDescriptor here;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size.fromWidth(24)),
            '/assets/images/cocukla_logo.png')
        .then((onValue) {
      here = onValue;
    });

    allMarkers.add(Marker(
        markerId: MarkerId("Buradasınız"),
        draggable: false,
        icon: here,
        onTap: () => print("Tapped to marker"),
        position: LatLng(AppData.position.latitude, AppData.position.longitude),
        visible: true,
        infoWindow: InfoWindow(
            title: "Buradasınız",
            snippet: "Snippet alanı",
            onTap: () {
              print("Clicked on emekte bir yer!");
            }),
        flat: true));

    allMarkers.add(Marker(
        markerId: MarkerId("Emekte bir yer"),
        draggable: false,
        onTap: () => print("Tapped to marker"),
        position: LatLng(39.921269, 32.817501),
        visible: true,
        infoWindow: InfoWindow(
            title: "Emekte bir yer",
            snippet: "Snippet alanı",
            onTap: () {
              print("Clicked on emekte bir yer!");
            }),
        flat: true));
    allMarkers.add(Marker(
        markerId: MarkerId("Emek Mahallesi 2"),
        draggable: false,
        onTap: () => print("Tapped to marker"),
        position: LatLng(39.923963, 32.818905),
        visible: true,
        infoWindow: InfoWindow(
            title: "Emek Mahallesi 2",
            snippet: "Snippet alanı",
            onTap: () {
              print("Clicked on emekte bir yer!");
            }),
        flat: true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 14,
              target: LatLng(
                  AppData.position.latitude, AppData.position.longitude)),
          markers: Set.from(allMarkers),
          onMapCreated: (controller) {
            setState(() {
              this.controller = controller;
            });
          },
        ),
      ),
    );
  }
}
