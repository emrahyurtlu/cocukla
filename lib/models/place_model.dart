import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/property_model.dart';

class PlaceModel {
  String id;
  String name;
  String digest;
  double rating;
  List<List<String>> properties;
  List<CommentModel> comments;
  List<String> photos;
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
      {this.id,
      this.name,
      this.digest,
      this.rating = 0,
      this.properties,
      this.comments,
      this.photos,
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
      : id = json["id"],
        name = json["name"],
        digest = json["digest"],
        rating = json["rating"],
        properties = json["properties"],
        comments = json["properties"],
        photos = json["photos"],
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
        'id': id,
        'name': name,
        'digest': digest,
        'properties': properties,
        'comments': comments,
        'photos': photos,
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
}
