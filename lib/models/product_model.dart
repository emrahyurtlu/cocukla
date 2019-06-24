import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/photo_model.dart';
import 'package:cocukla/models/property_model.dart';

class ProductModel {
  String title;
  String text;
  double star;
  List<PropertyModel> properties;
  List<CommentModel> comments;
  List<PhotoModel> photos;
  bool isFav;
  int editor_id;
  String phone_number;
  String address;
  String city;
  String district;

  ProductModel(
      {this.title,
      this.text,
      this.star,
      this.properties,
      this.comments,
      this.photos,
      this.isFav,
      this.editor_id,
      this.phone_number,
      this.address,
      this.city,
      this.district});
}
