import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentComponent extends StatefulWidget {
  final CommentModel model;

  const CommentComponent({Key key, this.model}) : super(key: key);

  @override
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              widget.model.imageLink,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget.model.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "MontserratRegular")),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: FlutterRatingBarIndicator(
                rating: widget.model.rating,
                itemCount: 5,
                itemSize: 12,
                emptyColor: AppColor.dark_gray,
                fillColor: AppColor.yellow,
                itemPadding: EdgeInsets.only(right: 2),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(widget.model.text,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 14, fontFamily: "MontserratLight"))),
          ],
        ),
      ],
    );
  }
}
