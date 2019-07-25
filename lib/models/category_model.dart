class CategoryModel {
  String documentID;
  int turn;
  String image;
  String title;

  CategoryModel({this.documentID, this.turn, this.image, this.title});

  CategoryModel.fromJson(Map<String, dynamic> json)
      : documentID = json["documentID"],
        turn = json["turn"],
        image = json["image"],
        title = json["title"];

  Map<String, dynamic> toJson() => {
        "id": documentID,
        "turn": turn,
        "image": image,
        "title": title,
      };

  @override
  String toString() {
    return 'CategoryModel{documentID: $documentID, turn: $turn, image: $image, title: $title}';
  }
}
