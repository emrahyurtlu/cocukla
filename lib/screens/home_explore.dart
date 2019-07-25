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

  @override
  void initState() {
    locateUser();
    allMarkers.add(Marker(
      markerId: MarkerId("Buradasınız"),
      draggable: false,
      onTap: () => print("Tapped to marker"),
      position: LatLng(AppData.position.latitude, AppData.position.longitude),
      visible: true,
    ));
  }

  Future<void> locateUser() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position value) => AppData.position = value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(39.915047, 32.819284), zoom: 14.0),
          markers: Set.from(allMarkers),
          onMapCreated: null,
        ),
      ),
    );
  }
}
