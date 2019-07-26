import 'package:cocukla/ui/components/card_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentScreen extends StatefulWidget {
  final String documentID;

  CommentScreen({Key key, this.documentID}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController;
  double _rating = 0;

  @override
  void initState() {
    commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yorum Yapın", style: AppStyle.AppBarTextStyle),
          backgroundColor: AppColor.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.text_color),
        ),
        body: SafeArea(
          child: CardComponent(
            child: ListView(
              children: <Widget>[
                Form(
                  key: GlobalKey(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "Oylayın",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: FlutterRatingBar(
                                initialRating: _rating,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(left: 3, right: 3),
                                itemSize: 25,
                                //borderColor: AppColor.text_color,
                                fullRatingWidget: Icon(
                                  Icons.star,
                                  size: 25,
                                  color: AppColor.yellow,
                                ),
                                noRatingWidget: Icon(
                                  Icons.star_border,
                                  size: 25,
                                  color: AppColor.text_color,
                                ),
                                halfRatingWidget: Icon(
                                  Icons.star,
                                  size: 25,
                                  color: AppColor.yellow,
                                ),
                                fillColor: AppColor.yellow,
                                onRatingUpdate: (double rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                }),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 20),
                        child: Text(
                          "Yorum yapın",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 122,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.light_gray,
                                ),
                                child: TextFormField(
                                  controller: commentController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelStyle:
                                        TextStyle(color: AppColor.text_color),
                                    labelText: 'Yorum yapın',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5, right: 5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: FlatButton(
                                color: AppColor.pink,
                                textColor: AppColor.white,
                                onPressed: () {
                                  print("Güncellendi!" +
                                      commentController.text +
                                      " rating is " +
                                      _rating.ceil().toString());
                                  Navigator.pop(context);
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0)),
                                child: Text(
                                  "Tamam",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Montserrat", fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
