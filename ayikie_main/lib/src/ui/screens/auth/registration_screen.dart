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
  int _value = 1;
  bool hideConfirmPassword = true;
  bool hidePassword = true;
  bool _isUser = true;

  @override
  void initState() {
    super.initState();
    _isUser = this.widget.userRole == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Country/Region :',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          width: 30,
                          height: 20,
                          child: Image.asset(
                            'asserts/images/flag.png',
                            fit: BoxFit.contain,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Ghana',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Join as a Buyer or Professional',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.greyLightColor),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 4, right: 4),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                'Please select trade role',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 80,
                                  width:
                                      (MediaQuery.of(context).size.width - 80) /
                                          2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'BUYER',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio<int>(
                                                value: 1,
                                                activeColor: Colors.white,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'I am abuying a \n product or service'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width:
                                      (MediaQuery.of(context).size.width - 80) /
                                          2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'PROFESSIONAL',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio<int>(
                                                value: 2,
                                                activeColor: Colors.white,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'I am selling a \n product or service'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //     GestureDetector(
                    //       onTap: () => setState(() {
                    //         _value = 1;
                    //       }),
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(20)),
                    //               color: _value == 1
                    //                   ? AppColors.selectedTextColor
                    //                   : Colors.transparent,
                    //               border: Border.all(
                    //                   width: 1.2, color: AppColors.black),
                    //             ),
                    //             height: 150,
                    //             width: 120,
                    //             child:
                    //                Text('data'),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 8.0),
                    //             child: Text(
                    //               'User',
                    //               style: TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w700),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () => setState(() {
                    //         _value = 2;
                    //       }),
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(20)),
                    //                 color: _value == 2
                    //                     ? AppColors.selectedTextColor
                    //                     : Colors.transparent,
                    //                 border: Border.all(
                    //                     width: 1.2, color: AppColors.black)),
                    //             height: 150,
                    //             width: 120,
                    //             child: SvgPicture.asset(
                    //                 'asserts/images/professional.svg'),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 8.0),
                    //             child: Text(
                    //               'Professional',
                    //               style: TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w700),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    ),

                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10),
                //   child: Container(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'Registration',
                //       style: TextStyle(
                //           fontSize: 26, fontWeight: FontWeight.w900),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Full Name',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Required',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomFormField(
                  controller: _nameController,
                  hintText: 'full name',
                  inputType: TextInputType.text,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone No',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Required',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomFormField(
                  controller: _phoneNoController,
                  hintText: 'enter your phone no',
                  inputType: TextInputType.number,
                 prefixEnable: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 20),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Required',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomFormField(
                  controller: _passwordController,
                  hintText: 'enter your password',
                  inputType: TextInputType.text,
                  suffixEnable: true,
                  suffixIcon: hidePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  suffixCallback: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  isObsucure: hidePassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 20),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Required',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomFormField(
                  controller: _confirmPasswordController,
                  hintText: 'enter your password again',
                  inputType: TextInputType.text,
                  suffixEnable: true,
                  suffixIcon: hideConfirmPassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  suffixCallback: () {
                    setState(() {
                      hideConfirmPassword = !hideConfirmPassword;
                    });
                  },
                  isObsucure: hideConfirmPassword,
                ),
                SizedBox(height: 40),
                // Row(
                //   children: [
                //     Radio<bool>(
                //       value: true,
                //       groupValue: _isUser,
                //       onChanged: (value) {
                //         setState(() {
                //           _isUser = value!;
                //         });
                //       },
                //     ),
                //     Text(
                //       "User",
                //       style:
                //           TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                //     ),
                //     SizedBox(width: 20),
                //     Radio<bool>(
                //       value: false,
                //       groupValue: _isUser,
                //       onChanged: (value) {
                //         setState(() {
                //           _isUser = value!;
                //         });
                //       },
                //     ),
                //     Text(
                //       "Professionals",
                //       style:
                //           TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // ),

                PrimaryButton(
                    text: 'CREATE MY ACCOUNT',
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
                          'already have an account?  ',
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
                            'Log In',
                            style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryButtonColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ));
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
