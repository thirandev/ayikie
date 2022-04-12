import 'package:ayikie_users/src/utils/common.dart';

class Images{
  int id;
  String imageName;

  Images({
    required this.id,
    required this.imageName,
  });

  getBannerUrl(){
    return Common.getImage(imageName: imageName);
  }

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      imageName:  json['name'],
    );
  }

}