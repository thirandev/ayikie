import 'package:ayikie_service/src/models/images.dart';

class Banners extends Images{
  int status;

  Banners({
    required int id,
    required this.status,
    required String bannerName,
  }) : super(id: id,imageName: bannerName);

  @override
  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['id'],
      status:  json['status'],
      bannerName:  json['images']['name'],
    );
  }
}
