import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String documentID;
  String name;
  String digest;
  String rating;
  List<dynamic> properties;
  List<dynamic> comments;
  List<dynamic> images;
  bool isFav;
  bool isApproved;
  bool isActive;
  bool isDeleted;
  String owner;
  String category;
  String phone;
  String email;
  String fax;
  String address;
  String city;
  String district;
  String location;
  Timestamp insertDate;
  Timestamp updateDate;

  PlaceModel(
      {this.documentID,
      this.name,
      this.digest,
      this.rating = "0",
      this.properties,
      this.comments,
      this.images,
      this.isFav = false,
      this.isApproved = false,
      this.isActive = false,
      this.isDeleted = false,
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

  PlaceModel.from({Map<String, dynamic> data, String documentID = ""})
      : documentID = documentID,
        name = data["name"],
        digest = data["digest"],
        rating = data["rating"],
        properties = data["properties"],
        comments = data["comments"],
        images = data["images"],
        isFav = data["isFav"],
        isApproved = data["isApproved"],
        isActive = data["isActive"],
        owner = data["owner"],
        category = data["category"],
        phone = data["phone"],
        email = data["email"],
        fax = data["fax"],
        address = data["address"],
        city = data["city"],
        district = data["district"],
        location = data["position"],
        isDeleted = data["isDeleted"],
        insertDate = data["insertDate"],
        updateDate = data["updateDate"];

  Map<String, dynamic> toJson() => {
        'documentID': documentID,
        'name': name,
        'digest': digest,
        'properties': properties,
        'comments': comments,
        'images': images,
        'isFav': isFav,
        'isApproved': isApproved,
        'isActive': isActive,
        'isDeleted': isDeleted,
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
        'email': email,
        'rating': rating
      };

  @override
  String toString() {
    return 'PlaceModel{documentID: $documentID, name: $name, digest: $digest, rating: $rating, properties: $properties, comments: $comments, images: $images, isFav: $isFav, isApproved: $isApproved, isActive: $isActive, isDeleted: $isDeleted, owner: $owner, category: $category, phone: $phone, email: $email, fax: $fax, address: $address, city: $city, district: $district, location: $location, insertDate: $insertDate, updateDate: $updateDate}';
  }
}
