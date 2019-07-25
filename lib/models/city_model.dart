class CityModel {
  String documentID;
  String name;
  String plate;
  List<String> districts;

  CityModel({this.name, this.plate, this.districts, this.documentID});

  CityModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        plate = json["plate"],
        documentID = json["documentID"],
        districts = json["districts"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "plate": plate,
        "districts": districts,
        "documentID": documentID,
      };

  @override
  String toString() {
    return 'CityModel{documentID: $documentID, name: $name, plate: $plate, districts: $districts}';
  }
}
