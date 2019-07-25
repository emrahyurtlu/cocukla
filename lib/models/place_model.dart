class PlaceModel {
  String documentID;
  String name;
  String digest;
  int rating;
  List<Map<String, dynamic>> properties;
  List<Map<String, dynamic>> comments;
  List<String> images;
  bool isFav;
  bool isApproved;
  bool isActive;
  String owner;
  String category;
  String phone;
  String email;
  String fax;
  String address;
  String city;
  String district;
  String location;
  DateTime insertDate;
  DateTime updateDate;

  PlaceModel(
      {this.documentID,
      this.name,
      this.digest,
      this.rating = 0,
      this.properties,
      this.comments,
      this.images,
      this.isFav = false,
      this.isApproved = false,
      this.isActive = false,
      this.owner,
      this.category,
      this.phone,
      this.email,
      this.fax,
      this.address,
      this.city,
      this.district,
      this.location,
      this.insertDate,
      this.updateDate});

  PlaceModel.fromJson(Map<String, dynamic> json)
      : documentID = json["documentID"],
        name = json["name"],
        digest = json["digest"],
        rating = json["rating"],
        properties = json["properties"],
        comments = json["properties"],
        images = json["photos"],
        isFav = json["isFav"],
        isApproved = json["isApproved"],
        isActive = json["isActive"],
        owner = json["owner"],
        category = json["category"],
        phone = json["phone"],
        email = json["email"],
        fax = json["fax"],
        address = json["address"],
        city = json["city"],
        district = json["district"],
        location = json["position"],
        insertDate = json["insertDate"],
        updateDate = json["updateDate"];

  Map<String, dynamic> toJson() => {
        'documentID': documentID,
        'name': name,
        'digest': digest,
        'properties': properties,
        'comments': comments,
        'photos': images,
        'isFav': isFav,
        'isApproved': isApproved,
        'isActive': isActive,
        'owner': owner,
        'category': category,
        'phone': phone,
        'fax': fax,
        'address': address,
        'city': city,
        'district': district,
        'position': location,
        'insertDate': insertDate,
        'updateDate': updateDate,
      };

  @override
  String toString() {
    return 'PlaceModel{documentID: $documentID, name: $name, digest: $digest, rating: $rating, properties: $properties, comments: $comments, photos: $images, isFav: $isFav, isApproved: $isApproved, isActive: $isActive, owner: $owner, category: $category, phone: $phone, email: $email, fax: $fax, address: $address, city: $city, district: $district, location: $location, insertDate: $insertDate, updateDate: $updateDate}';
  }
}
