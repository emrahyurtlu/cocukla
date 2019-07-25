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
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 5),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                widget.model.image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //Comment Name
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(widget.model.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: "MontserratRegular")),
              ),
              //Comment Rating
              Container(
                margin: EdgeInsets.only(left: 50),
                child: FlutterRatingBarIndicator(
                  rating: widget.model.rating,
                  itemCount: 5,
                  itemSize: 12,
                  emptyColor: AppColor.dark_gray,
                  fillColor: AppColor.yellow,
                  itemPadding: EdgeInsets.only(right: 2),
                ),
              ),
              //Comment Text
              Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(widget.model.content,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14, fontFamily: "MontserratLight"))),
            ],
          ),
        ],
      ),
    );
  }
}
