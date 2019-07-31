import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
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
      {this.name,
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

  PlaceModel.from(Map<String, dynamic> json)
      : name = json["name"],
        digest = json["digest"],
        rating = json["rating"],
        properties = json["properties"],
        comments = json["comments"],
        images = json["images"],
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
        isDeleted = json["isDeleted"],
        insertDate = json["insertDate"],
        updateDate = json["updateDate"];

  Map<String, dynamic> toJson() => {
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
    return 'PlaceModel{name: $name, digest: $digest, rating: $rating, properties: $properties, comments: $comments, images: $images, isFav: $isFav, isApproved: $isApproved, isActive: $isActive, isDeleted: $isDeleted, owner: $owner, category: $category, phone: $phone, email: $email, fax: $fax, address: $address, city: $city, district: $district, location: $location, insertDate: $insertDate, updateDate: $updateDate}';
  }
}
