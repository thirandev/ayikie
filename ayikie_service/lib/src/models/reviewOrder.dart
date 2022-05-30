import 'package:ayikie_service/src/models/images.dart';

class ReviewOrder {
  int id;
  String comment;
  int rate;
  String createdAt;
  Images image;

  ReviewOrder(
      {required this.id,
        required this.comment,
        required this.rate,
        required this.createdAt,
        required this.image,
      });

  @override
  factory ReviewOrder.fromJson(Map<String, dynamic> json) {
    return ReviewOrder(
        id: json['id'],
        comment: json['comment'],
        rate: json['rate'],
        createdAt: json['created_at'],
        image: json['images'] != null ? Images.fromJson(json['images']):Images(id: 1, imageName: "89b1e72d4027670d20c73440d5da3041.jpg"),
    );
  }
}
