import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentFormComponent extends StatefulWidget {
  final TextEditingController textEditingController;

  const CommentFormComponent({Key key, this.textEditingController}) : super(key: key);
  @override
  _CommentFormComponentState createState() => _CommentFormComponentState();
}

class _CommentFormComponentState extends State<CommentFormComponent> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            FlutterRatingBar(
              initialRating: 0,
              itemCount: 5,
              itemPadding: EdgeInsets.only(
                  left: 3, right: 3),
              itemSize: 25,
              borderColor:
              AppColor.dark_gray,
              fullRatingWidget: Icon(
                Icons.star,
                size: 25,
                color: AppColor.yellow,
              ),
              noRatingWidget: Icon(
                Icons.star_border,
                size: 25,
                color: AppColor.dark_gray,
              ),
              halfRatingWidget: Icon(
                Icons.star,
                size: 25,
                color: AppColor.yellow,
              ),
              fillColor: AppColor.yellow,
              onRatingUpdate:
                  (double rating) => print(
                  "Rated as " +
                      rating
                          .ceil()
                          .toString()),
            )
          ],
        ),

        //Textarea
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color:
                    AppColor.light_gray,
                    borderRadius:
                    BorderRadius
                        .circular(10)),
                child: TextField(
                  controller: widget.textEditingController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "Yorum yapın...",
                      hintText:
                      "Yorum yapın...",
                      border:
                      InputBorder.none),
                ),
              ),
            ),
          ],
        ),

        //SubmitButton
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              color: AppColor.pink,
              textColor: AppColor.white,
              onPressed: () => print("Comment is sumbitted!"),
              shape:
              new RoundedRectangleBorder(
                  borderRadius:
                  new BorderRadius
                      .circular(
                      50.0)),
              child: Text(
                "Kaydet",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily:
                    "Montserrat",
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
