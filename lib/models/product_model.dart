import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/photo_model.dart';
import 'package:cocukla/models/property_model.dart';

class ProductModel {
  String id;
  String title;
  String text;
  double rating;
  List<PropertyModel> properties;
  List<CommentModel> comments;
  List<PhotoModel> photos;
  bool isFav;
  String editor_id;
  String category_id;
  String phone_number;
  String email;
  String fax;
  String address;
  String city;
  String district;

  ProductModel(
      {this.id,
      this.title,
      this.text,
      this.rating,
      this.properties,
      this.comments,
      this.photos,
      this.isFav,
      this.editor_id,
      this.phone_number,
      this.address,
      this.city,
      this.district,
      this.email,
      this.fax});
}
