import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/models/place_model.dart';
import 'package:cocukla/ui/screens/place_detail.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/route.dart';
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
  final _scaffoldState = GlobalKey<ScaffoldState>();
  final BitmapDescriptor _markerIcon =
      BitmapDescriptor.fromAsset('assets/images/marker.png');

  @override
  void initState() {
    allMarkers.add(Marker(
      markerId: MarkerId("Buradasınız"),
      draggable: false,
      consumeTapEvents: false,
      onTap: () => print("Tapped to marker"),
      position: LatLng(AppData.position.latitude, AppData.position.longitude),
      visible: true,
      icon: _markerIcon,
      infoWindow: InfoWindow(
          title: "Buradasınız",
          onTap: () {
            print("Clicked on buradasınız!");
          }),
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _scaffoldState,
      child: Container(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 14,
              target: LatLng(
                  AppData.position.latitude, AppData.position.longitude)),
          //Haritayı kullanıcının lokasyonuna göre merkezler
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

  getData() async {
    var markers = List<Marker>();
    var result = await Firestore.instance
        .collection(Collections.Places)
        .where("isActive", isEqualTo: true)
        .where("isApproved", isEqualTo: true)
        .where("city", isEqualTo: AppData.placemarks.first.administrativeArea)
        .getDocuments();
    if (result.documents.length > 0) {
      for (var place in result.documents) {
        var model =
            PlaceModel.from(data: place.data, documentID: place.documentID);
        var location = model.position.split(",");
        var marker = Marker(
            markerId: MarkerId(model.name),
            icon: _markerIcon,
            draggable: false,
            position:
                LatLng(double.parse(location[0]), double.parse(location[1])),
            visible: true,
            infoWindow: InfoWindow(
                title: model.name,
                snippet: model.digest,
                onTap: () {
                  redirectTo(
                      context,
                      PlaceDetail(
                        data: model.toJson(),
                        documentID: model.documentID,
                      ));
                }));
        markers.add(marker);
      }

      setState(() {
        allMarkers = markers;
      });
    }
    return markers;
  }
}
