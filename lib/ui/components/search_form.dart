import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';

class SearchFormComponent extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  const SearchFormComponent({Key key, @required this.controller, @required this.onPressed})
      : super(key: key);

  @override
  _SearchFormComponentState createState() => _SearchFormComponentState();
}

class _SearchFormComponentState extends State<SearchFormComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
          border: Border.all(color: Colors.white),
          color: AppColor.white),
      child: Row(
        children: <Widget>[
          Form(
            key: GlobalKey(),
            child: Center(
                child: Column(
              children: <Widget>[
                SizedBox(
                  width: 280,
                  height: 48,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 0, top: 0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColor.light_gray,
                          ),
                          child: TextFormField(
                            controller: widget.controller,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: AppColor.text_color),
                              labelText: "Mekan arayın",
                              //hintText: "Ara",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 25, top: 5),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          SizedBox(
            width: 10,
            height: 40,
          ),
          SizedBox(
              width: 60,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.pink,
                ),
                child: Container(
                  width: 60,
                  height: 40,
                  child: FlatButton(
                    color: AppColor.pink,
                    textColor: AppColor.white,
                    onPressed: widget.onPressed,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0)),
                    child: Icon(
                      Icons.search,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
