import 'dart:io';

import 'package:ayikie_main/src/api/api_calls.dart';
import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/ui/widgets/custom_form_field.dart';
import 'package:ayikie_main/src/ui/widgets/primary_button.dart';
import 'package:ayikie_main/src/utils/alerts.dart';
import 'package:ayikie_main/src/utils/settings.dart';
import 'package:ayikie_main/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationScreen extends StatefulWidget {
  final int userRole;

  const RegistrationScreen({Key? key, required this.userRole})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  bool _isUser = true;

  @override
  void initState() {
    super.initState();
    _isUser = this.widget.userRole == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    child: SvgPicture.asset(
                        'asserts/images/registration_logo.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Registration',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Full Name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  CustomFormField(
                    controller: _nameController,
                    hintText: 'full name',
                    inputType: TextInputType.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phone No',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  CustomFormField(
                    controller: _phoneNoController,
                    hintText: 'phone no',
                    inputType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  CustomFormField(
                    controller: _passwordController,
                    hintText: 'password',
                    inputType: TextInputType.text,
                    isObsucure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  CustomFormField(
                    controller: _confirmPasswordController,
                    hintText: 'confirm password',
                    inputType: TextInputType.text,
                    isObsucure: true,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _isUser,
                        onChanged: (value) {
                          setState(() {
                            _isUser = value!;
                          });
                        },
                      ),
                      Text(
                        "User",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 20),
                      Radio<bool>(
                        value: false,
                        groupValue: _isUser,
                        onChanged: (value) {
                          setState(() {
                            _isUser = value!;
                          });
                        },
                      ),
                      Text(
                        "Professionals",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  PrimaryButton(
                      text: 'Register',
                      fontSize: 12,
                      clickCallback: onRegisterPress),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Don\'t have an account?  ',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/LoginScreen');
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryButtonColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
          )),
    );
  }

  void onRegisterPress() {
    String username = _nameController.text.trim();
    String phone = _phoneNoController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String deviceName = Platform.isAndroid ? "android" : "ios";
    int role = _isUser ? 1 : 2;

    if (!Validations.validateString(username)) {
      Alerts.showMessage(context, "Enter your name");
      return;
    }

    if (!Validations.validateMobileNumber(phone)) {
      Alerts.showMessage(context, "Invalid mobile number");
      return;
    }

    if (!Validations.validateString(password)) {
      Alerts.showMessage(context, "Invalid password number");
      return;
    }

    if (password != confirmPassword) {
      Alerts.showMessage(context, "Passwords doesn't match");
      return;
    }

    ApiCalls.register(
            username: username,
            phone: phone,
            password: password,
            userRole: role,
            deviceName: deviceName)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        await Settings.setAccessToken(response.jsonBody);
        Navigator.pushNamed(context, '/SendOtpScreen');
      } else {
        Alerts.showMessageForResponse(context, response);
      }
    });
  }
}
