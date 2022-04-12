import 'package:ayikie_users/src/utils/common.dart';

class Banners{
  int id;
  int status;
  String bannerName;

  Banners({
    required this.id,
    required this.status,
    required this.bannerName,
  });

  getBannerUrl(){
    return Common.getImage(imageName: bannerName);
  }

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['id'],
      status:  json['status'],
      bannerName:  json['images']['name'],
    );
  }
}
