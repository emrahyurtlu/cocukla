import 'dart:core';

import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  //GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

  bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();

  return isLocationEnabled
      ? _getCurrentDeviceLocation()
      : _getLastKnownPosition();
}

Future<Position> _getCurrentDeviceLocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<Position> _getLastKnownPosition() async {
  Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<String> getCityName() async {
  Position position = await getLocation();
  String name = "";
  var addrInfoList = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);

  if (addrInfoList.length > 0) {
    var info = addrInfoList[0];
    name = info.administrativeArea;
  }
  return name;
}

Future<String> getDistrictName() async {
  Position position = await getLocation();
  String name = "";
  var addrInfoList = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);

  if (addrInfoList.length > 0) {
    var info = addrInfoList[0];
    name = info.subAdministrativeArea;
  }
  return name;
}

Future<List<Placemark>> getAddrInfo() async {
  Position position = await getLocation();
  var addrInfoList = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);

  return addrInfoList;
}
