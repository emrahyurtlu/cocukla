import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/datalayer/collections.dart';
import 'package:cocukla/ui/components/button_component.dart';
import 'package:cocukla/ui/components/card_component.dart';
import 'package:cocukla/ui/components/header_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/screens/place_detail.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CommentScreen extends StatefulWidget {
  final String documentID;
  final Map<String, dynamic> data;

  CommentScreen({Key key, this.documentID, this.data}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController commentController;
  double _rating = 1;

  @override
  void initState() {
    commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    redirectIfNotSignedIn(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                      HeaderComponent(
                        "Oylayın",
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: EdgeInsets.only(top: 20),
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
                      HeaderComponent(
                        "Yorum yapın",
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: EdgeInsets.only(top: 20),
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
                      ButtonComponent(
                        text: "Tamam",
                        onPressed: () {
                          var comment = commentController.text.trim();
                          if (comment.isNotEmpty) {
                            Map<String, dynamic> temp = {
                              "content": comment,
                              "rating": _rating,
                              "name": AppData.user.name,
                              "owner": AppData.user.email,
                              "isApproved": false,
                              "timestamp": Timestamp.now()
                            };
                            /*var comments = List.of(widget.data["comments"]);
                            comments.add(temp);*/

                            Firestore.instance
                                .collection(Collections.Places)
                                .document(widget.documentID)
                                .setData({"comments": temp}, merge: true).then(
                                    (_) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "Yorumunuz eklendi. Onay işleminden sonra yayınlanacaktır."),
                                action: SnackBarAction(
                                  label: "Geri dön",
                                  onPressed: () {
                                    redirectTo(
                                        context,
                                        PlaceDetail(
                                          documentID: widget.documentID,
                                          data: widget.data,
                                        ));
                                  },
                                ),
                              ));
                            });
                            //.updateData({"comments": comments});
                          } else {
                            Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Dikkat",
                                desc: "Yorum metni boş olamaz",
                                buttons: <DialogButton>[
                                  DialogButton(
                                    child: Text(
                                      "Tamam",
                                      style: TextStyle(color: AppColor.white),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ]);
                          }
                        },
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
