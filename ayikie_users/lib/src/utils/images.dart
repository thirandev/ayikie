import 'package:flutter/material.dart';

class Images {
  static AssetImage getImage(String image) {
    return AssetImage(image, package: "ayikie_users");
  }
}
