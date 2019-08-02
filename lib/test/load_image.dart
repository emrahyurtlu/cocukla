import 'dart:io';

import 'package:cocukla/ui/components/conditional_component.dart';
import 'package:cocukla/utilities/image_uploaderv2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File _file;

  @override
  void initState() {
    _file = File("assets/images/user.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text("Take Image"),
            onPressed: () async {
              var temp = await getImage();
              setState(() {
                _file = temp;
              });
            },
          ),
          ConditionalComponent(
            condition: _file != null,
            children: <Widget>[
              Image.file(
                _file,
                width: 100,
              )
            ],
          )
        ],
      ),
    );
  }
}
