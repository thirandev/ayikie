class Notifications {
  int id;
  int userId;
  String title;
  String message;
  String createdAt;

  Notifications(
      {required this.id,
        required this.userId,
        required this.title,
        required this.message,
        required this.createdAt});

  @override
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
        id: json['id'],
        userId: json['user_id'],
        title: json['title'],
        message: json['msg'],
        createdAt: json['created_at']
    );
  }
}