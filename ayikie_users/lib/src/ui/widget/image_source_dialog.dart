import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';

class ImageSourceDialog {
  static void show(BuildContext context, Function onSelectCallback) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0x00000000),
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Material(
              color: AppColors.transparent,
              child: _Widget(onSelectCallback),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

class _Widget extends StatelessWidget {
  final Function onSelectCallback;

  _Widget(this.onSelectCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x20000000),
            offset: Offset(2, 4),
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Align(
              alignment: AlignmentDirectional.topEnd,
              child:  GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.gray,
                  size: 25,
                ),
              )
            ),

          SizedBox(height: 5),
          PrimaryButton(
              text: "Take a Photo",
              clickCallback: () {
                Navigator.of(context).pop();
                onSelectCallback(1);
              },
            fontSize: 16,
            prexIcon: Icon(
              Icons.camera_alt
            ),
              ),
          SizedBox(height: 16),
          PrimaryButton(
            bgColor: Colors.white,
            borderWidth: 1,
            borderColor: AppColors.primaryButtonColor,
            text: "Upload from Gallery",
            textColor: AppColors.primaryButtonColor,
            clickCallback: () {
              Navigator.of(context).pop();
              onSelectCallback(0);
            },
            fontSize: 16,
            prexIcon: Icon(
                Icons.photo,
              color: AppColors.primaryButtonColor,
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}
