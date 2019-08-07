import 'package:cocukla/ui/components/card_component.dart';
import 'package:cocukla/utilities/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingToApprove extends StatelessWidget {
  final Map<String, dynamic> data;
  final String documentID;

  const WaitingToApprove({Key key, this.data, this.documentID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Onay bekleniyor", style: AppStyle.AppBarTextStyle,),),
        body: CardComponent(
          child: Center(
            child: Text("Bu kayıt yayında değil. Yayınlanması için onay bekleniyor."),
          ),
        ),
      ),
    );
  }
}
