import 'package:cocukla/ui/config/files.dart';
import 'package:cocukla/utilities/load_file.dart';
import 'package:flutter/material.dart';

class LoadCityTest extends StatefulWidget {
  @override
  _LoadCityTestState createState() => _LoadCityTestState();
}

class _LoadCityTestState extends State<LoadCityTest> {
  var cities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("Load Cities"),
                onPressed: () async {
                  var temp = await loadStaticFile(Files.cities);
                  setState(() {
                    cities = temp;
                  });
                  for (var item in cities) {
                    //Firestore.instance.collection("cities").add(item);
                    //print("EKLENEN ==> " +item["city_name"]);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
