import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String documentID;
  String owner;
  String name;
  bool isApproved;
  String content;
  double rating;
  Timestamp timestamp;

  CommentModel(
      {this.name, this.owner, this.isApproved, this.rating, this.content, this.timestamp});


  CommentModel.from(Map<dynamic, dynamic> json, [String documentID])
      : documentID = documentID,
        owner = json["owner"],
        name = json["name"],
        isApproved = json["isApproved"],
        content = json["content"],
        rating = double.parse(json["rating"].toString()),
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "content": content,
        "rating": rating,
        "date": timestamp,
        "documentID": documentID,
      };

  @override
  String toString() {
    return 'CommentModel{documentID: $documentID, name: $name, content: $content, rating: $rating, date: $timestamp}';
  }
}
