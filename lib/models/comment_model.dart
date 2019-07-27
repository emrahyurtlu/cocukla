import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String documentID;
  String image;
  String name;
  String content;
  double rating;
  Timestamp date;

  CommentModel(
      {this.image,
      this.name,
      this.content,
      this.rating,
      this.date,
      this.documentID});

  CommentModel.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        name = json["name"],
        content = json["content"],
        rating = double.parse(json["rating"]),
        date = json["date"],
        documentID = json["documentID"];

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "content": content,
        "rating": rating,
        "date": date,
        "documentID": documentID,
      };

  @override
  String toString() {
    return 'CommentModel{documentID: $documentID, image: $image, name: $name, content: $content, rating: $rating, date: $date}';
  }
}
