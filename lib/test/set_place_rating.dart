import 'package:cocukla/business/place_service.dart';
import 'package:cocukla/models/comment_model.dart';
import 'package:flutter/material.dart';

class SetPlaceRating extends StatefulWidget {
  @override
  _SetPlaceRatingState createState() => _SetPlaceRatingState();
}

class _SetPlaceRatingState extends State<SetPlaceRating> {
  PlaceService _service;

  @override
  initState() {
    _service = PlaceService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: RaisedButton(
          child: Text("Calculate Rating"),
          onPressed: () async {
            await _service.setRating("JvqYdiAVGcznlCqqNzTG");
          },
        ),
      )),
    );
  }

  List<CommentModel> convertComments(List comments) {
    var result = List<CommentModel>();

    if (comments.length > 0) {
      comments.forEach((item) {
        var model = CommentModel(
            rating: double.parse(item["rating"].toString()),
            name: item["name"],
            content: item["content"],
            timestamp: item["date"]);
        result.add(model);
      });
    }
    return result;
  }
}
