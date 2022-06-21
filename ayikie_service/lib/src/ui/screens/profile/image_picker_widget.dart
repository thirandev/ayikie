import 'dart:io';
import 'package:flutter/material.dart';

import 'custom_half_circle_clipper.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? image;
  final String url;

  const ImagePickerWidget({
    Key? key,
    required this.image,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        GestureDetector(
          onTap: (){
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              alignment: Alignment.center,
              child: ClipOval(
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: image == null
                      ? FadeInImage.assetNetwork(
                          placeholder: 'asserts/icons/default_profile.png',
                          placeholderScale: 10,
                          imageErrorBuilder: (context, url, error) => Image.asset(
                            'asserts/icons/default_profile.png',
                            fit: BoxFit.cover,
                          ),
                          image: url,
                          fit: BoxFit.cover,
                        )
                      : Image.file(image!, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomHalfCircleClipper(),
          child: Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0x33000000),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Image.asset(
            'asserts/icons/camera.png',
            width: 20,
            height: 20,
          ),
        )
      ],
    );
  }
}
