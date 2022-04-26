import 'dart:io';

import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/user.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/ui/widget/image_source_dialog.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/validations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  late File _profilePic;

  bool _isLoading = true;
  bool _isEditable = true;
  late User _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    await ApiCalls.getUser().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        _user = User.fromJson(response.jsonBody["data"]);
        _fullNameController.text = _user.name;
        _emailController.text = _user.email;
        _addressController.text = _user.address;
        _phoneNumberController.text = _user.phone;
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _isLoading
          ? Center(
        child: ProgressView(),
      )
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap:_updateProfilePicture,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryButtonColor),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                alignment:
                                AlignmentDirectional.topCenter),
                          ),
                        ),
                    imageUrl:_user.imgUrl.getBannerUrl(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.account_circle_sharp,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              CustomFormField(
                isEnabled: _isEditable,
                controller: _fullNameController,
                hintText: 'Enter your full name',
                inputType: TextInputType.text,
              ),
              Container(
                padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              CustomFormField(
                isEnabled: _isEditable,
                controller: _emailController,
                hintText: 'Enter your email',
                inputType: TextInputType.emailAddress,
              ),
              Container(
                padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Address',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              CustomFormField(
                isEnabled: _isEditable,
                controller: _addressController,
                hintText: 'Enter your full name',
                inputType: TextInputType.text,
              ),
              Container(
                padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              CustomFormField(
                isEnabled: _isEditable,
                controller: _phoneNumberController,
                hintText: 'Enter your phone number',
                inputType: TextInputType.phone,
                prefixEnable: true,
              ),
              SizedBox(
                height: 30,
              ),
              PrimaryButton(
                  text: _isEditable ? 'Edit' : 'Save',
                  fontSize: 16,
                  clickCallback: onBtnClick),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfilePicture() {
    ImageSourceDialog.show(context, _selectProfilePicture);
  }

  Future _selectProfilePicture(int mode) async {
    if (mode == 1) {
      try {
        var image = await ImagePicker().getImage(
            source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
        if (image != null) {
          _profilePic = File(image.path);
          print(_profilePic);
          _uploadPhotos();
        }
      } on PlatformException catch (e) {
        Alerts.showMessage(context,
            "Access to the camera has been denied, please enable it to continue.");
      } catch (e) {
        Alerts.showMessage(context, e.toString());
      }
    } else {
      try {
        var image = await ImagePicker().getImage(
            source: ImageSource.gallery, maxWidth: 400, maxHeight: 400);
        if (image != null) {
          _profilePic = File(image.path);
          print('here');
          _uploadPhotos();
        }
      } on PlatformException catch (e) {
        Alerts.showMessage(context,
            "Access to the gallery has been denied, please enable it to continue.");
      } catch (e) {
        Alerts.showMessage(context, e.toString());
      }
    }
  }

  void _uploadPhotos() async {
    setState(() {
      _isLoading = true;
    });
    var responseUpload = await ApiCalls.updateUserProfile(_profilePic);
    if (responseUpload.isSuccess) {
      User user = User.fromJson(responseUpload.jsonBody);
      setState(() {
        _user = user;
      });

    } else {
      Alerts.showMessageForResponse(context, responseUpload);
    }
    setState(() {
      _isLoading = false;
    });
  }


  void onBtnClick() {
    if (!_isEditable) {
      String username = _fullNameController.text.trim();
      String email = _emailController.text.trim();
      String address = _addressController.text.trim();
      String phone = _phoneNumberController.text.trim();

      if (!Validations.validateString(username)) {
        Alerts.showMessage(context, "Enter your name");
        return;
      }

      if (!Validations.validateMobileNumber(phone)) {
        Alerts.showMessage(context, "Invalid mobile number");
        return;
      }

      setState(() {
        _isLoading = true;
      });
      ApiCalls.updateUser(
          username: username, email: email, phone: phone, address: address)
          .then((response) async {
        if (!mounted) {
          return;
        }
        if (response.isSuccess) {
          Alerts.showMessage(
            context, "Profile updated sucessfully.",
            title: "Success!",);
        } else {
          Alerts.showMessageForResponse(context, response);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }

    setState(() {
      _isLoading = false;
      _isEditable = !_isEditable;
    });
  }
}
