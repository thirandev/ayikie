import 'package:ayikie_service/src/models/user.dart';

class Comment {
  int id;
  String comment;
  int rate;
  String createdAt;
  User user;

  Comment(
      {required this.id,
        required this.comment,
        required this.rate,
        required this.createdAt,
        required this.user});

  @override
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        comment: json['comment'],
        rate: json['rate'],
        createdAt: json['created_at'],
        user: User.fromJson(json['customer']));
  }
}
