import 'dart:io';

import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/user.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/ui/widget/image_source_dialog.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/validations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreaterequestScreen extends StatefulWidget {
  const CreaterequestScreen({Key? key}) : super(key: key);

  @override
  _CreaterequestScreenState createState() => _CreaterequestScreenState();
}

class _CreaterequestScreenState extends State<CreaterequestScreen> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  

  bool _isLoading = true;
  bool _isEditable = true;
  late User _user;

  @override
  void initState() {
    super.initState();
    
  }

  // void _getUserData() async {
  //   await ApiCalls.getUser().then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     if (response.isSuccess) {
  //       _user = User.fromJson(response.jsonBody);
  //       _fullNameController.text = _user.name;
  //       _emailController.text = _user.email;
  //       _addressController.text = _user.address;
  //       _phoneNumberController.text = _user.phone;
  //     } else {
  //       Alerts.showMessage(context, "Something went wrong. Please try again.",
  //           title: "Oops!");
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _categoryController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Post a Request',
          style: TextStyle(color: Colors.black),
        ),
        leading: Container(
          width: 24,
          height: 24,
          child: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return NotificationScreen();
                          }),
                        );
                      },
                      child: Container(
                        width: 26,
                        height: 26,
                        child: new Icon(
                          Icons.notifications_none,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 26,
                      height: 26,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(180 / 360),
                        child: Image.asset(
                          'asserts/icons/menu.png',
                          scale: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
      body:
      //  _isLoading
      //     ? Center(
      //         child: ProgressView(),
      //       )
      //     :
           SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16,top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                
                    Container(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    
                    CustomFormField(
                      isEnabled: _isEditable,
                      controller: _locationController,
                      hintText: 'Enter your location',
                      inputType: TextInputType.text,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      isEnabled: _isEditable,
                      controller: _categoryController,
                      hintText: 'Select your category',
                      inputType: TextInputType.emailAddress,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sub Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      isEnabled: _isEditable,
                      controller: _addressController,
                      hintText: 'select your sub category',
                      inputType: TextInputType.text,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      isEnabled: _isEditable,
                      controller: _phoneNumberController,
                      hintText: 'enter description here',
                      inputType: TextInputType.phone,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delivery Period',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      isEnabled: _isEditable,
                      controller: _phoneNumberController,
                      hintText: 'enter delivery period here',
                      inputType: TextInputType.phone,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Budget',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      isEnabled: _isEditable,
                      controller: _phoneNumberController,
                      hintText: 'enter your budget here',
                      inputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        text: 'Post',
                        fontSize: 16,
                        clickCallback: (){}),
                         SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}