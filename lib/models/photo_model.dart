class PhotoModel {
  String documentID;
  int turn;
  String image;

  PhotoModel({this.turn, this.image, this.documentID});

  PhotoModel.fromJson(Map<String, dynamic> json)
      : turn = json["turn"],
        documentID = json["documentID"],
        image = json["image"];

  Map<String, dynamic> toJson() => {
        "turn": turn,
        "image": image,
        "documentID": documentID,
      };

  @override
  String toString() {
    return 'PhotoModel{documentID: $documentID, turn: $turn, image: $image}';
  }


}
