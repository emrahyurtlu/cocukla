import 'package:cocukla/utilities/city_info.dart';
import 'package:flutter/material.dart';

class GetCities extends StatefulWidget {
  @override
  _GetCitiesState createState() => _GetCitiesState();
}

class _GetCitiesState extends State<GetCities> {
  @override
  Widget build(BuildContext context) {
    List<String> cities;
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Get List From DB"),
            onPressed: () async {
              /*getCityList().then((cityList) {
                setState(() {
                  cities = cityList;
                });
              }).whenComplete(() => print(cities));*/
              var dist = getDistrictList("İstanbul");
              print(dist);
            },
          ),
        ),
      ),
    );
  }
}
