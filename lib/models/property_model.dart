import 'package:cocukla/ui/config/app_color.dart';
import 'package:flutter/material.dart';

class PropertyModel {
  String documentID;
  int turn;
  String iconName;
  String content;
  double size;
  Color color;
  EdgeInsets padding;

  PropertyModel(
      {this.turn,
      this.iconName,
      this.content,
      this.documentID,
      this.size = 14,
      this.color = AppColor.dark_gray,
      this.padding = const EdgeInsets.all(0)});

  PropertyModel.from(Map<String, dynamic> json)
      : turn = json["turn"],
        iconName = json["iconName"],
        documentID = json["documentID"],
        content = json["content"];

  Map<String, dynamic> toJson() => {
        "documentID": documentID,
        "turn": turn,
        "iconName": iconName,
        "content": content,
        "size": size,
        "color": color,
        "padding": padding,
      };

  @override
  String toString() {
    return 'PropertyModel{documentID: $documentID, turn: $turn, iconName: $iconName, content: $content, size: $size, color: $color, padding: $padding}';
  }
}
