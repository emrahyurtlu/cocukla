import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
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
              CachedNetworkImage(
                imageUrl: widget.model.image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/cocukla_logo.png",
                  width: 40,
                ),
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
                    style: AppStyle.CommentNameTextStyle),
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
                      style: AppStyle.CommentContentTextStyle)),
            ],
          ),
        ],
      ),
    );
  }
}
