import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeExplore extends StatefulWidget {
  @override
  _HomeExploreState createState() => _HomeExploreState();
}

class _HomeExploreState extends State<HomeExplore> {
  var location = new Location();
  Map<String, double> currentLocation;

  List<Marker> allMarkers = [];
  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId("my_marker"),
        draggable: false,
        onTap: () => print("Tapped to marker"),
        position: LatLng(39.915047, 32.819284),
        visible: true,
        infoWindow: InfoWindow(
            title: "Hazine Bahçesi",
            snippet: "Burası Hazine ve Maliye Bakanlığı bahçesidir.",
            onTap: () => print("Infowindow okundu."))));

    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value as Map<String, double>;
      });
    });
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          //Map
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation["latitude"],
                      currentLocation["longitude"]),
                  zoom: 14.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
        ],
      ),
    );
  }
}
