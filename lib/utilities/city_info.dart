import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/utilities/address_statics.dart';

List<String> cities = List<String>();

Future<List<String>> getCityList() async {
  Firestore.instance
      .collection(Collections.Cities)
      .getDocuments()
      .then((result) {
    result.documents.forEach((document) {
      var name = document["city_name"];
      cities.add(name);
    });
  });
  return cities;
}

List<String> getDistrictList(String cityName) {
  List<String> districts = List<String>();
  AddressStatics.citiesFull.forEach((item) {
    if (item["city_name"] == cityName) districts = item["districts"];
  });
  print("Selected city is: " + cityName);
  print("Selected city districts are: " + districts.toString());
  return districts;
}
