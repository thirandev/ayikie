import 'dart:io';

import 'package:ayikie_main/src/api/api_calls.dart';
import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/models/user.dart';
import 'package:ayikie_main/src/ui/screens/auth/registration_screen.dart';
import 'package:ayikie_main/src/ui/widgets/custom_form_field.dart';
import 'package:ayikie_main/src/ui/widgets/primary_button.dart';
import 'package:ayikie_main/src/utils/alerts.dart';
import 'package:ayikie_main/src/utils/settings.dart';
import 'package:ayikie_main/src/utils/validations.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
//import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _value = 1;
  String? currentCountryCode;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  bool hidePassword = true;
  bool _isGoogleLoged = false;
  GoogleSignInAccount? googleSignInAccount;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Map? facebookUserData;
  String? socialUserName;
  String? socialUserPhotourl;
  String? socialUserId;
  String? socialUserEmail;
  String? socialUserServerAuthCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  Container(
                    alignment: Alignment.center,
                    height: 120,
                    child: Image.asset('asserts/images/ayikie_logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Log In to Ayikie',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10),
                  //   child: Container(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Select Your role',
                  //       style: TextStyle(
                  //           fontSize: 14, fontWeight: FontWeight.w700),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.greyLightColor),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 4, right: 4),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 80,
                                    width: (MediaQuery.of(context).size.width -
                                            80) /
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
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                    width: (MediaQuery.of(context).size.width -
                                            80) /
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
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phone No',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                  CustomFormField(
                    controller: _phoneNoController,
                    hintText: 'enter your phone no',
                    inputType: TextInputType.number,
                    countryCode: _countryCodeChange,
                    prefixEnable: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
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
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            'Forget Password?  ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/ForgetPasswordScreen');
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primaryButtonColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                      text: 'LOG IN',
                      fontSize: 12,
                      clickCallback: () {
                        onLogInPress();
                      }),
                  SizedBox(height: 20),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: AppColors.black.withOpacity(0.5),
                    )),
                    Text("OR"),
                    Expanded(
                        child:
                            Divider(color: AppColors.black.withOpacity(0.5))),
                  ]),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          facebookSignIn();
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            child: Image.asset('asserts/images/facebook.png')),
                        // padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        textColor: Colors.white,
                        child: Container(
                            height: 40,
                            width: 40,
                            child: Image.asset('asserts/images/twitter.png')),
                        shape: CircleBorder(),
                      ),
                      MaterialButton(
                        onPressed: () {
                          googleSignIn();
                        },
                        textColor: Colors.white,
                        child: Container(
                            height: 40,
                            width: 40,
                            child: Image.asset('asserts/images/google.png')),
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Don\'t have an account?  ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RegistrationScreen(userRole: _value),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: AppColors.primaryButtonColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     bottom: 40,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         child: Text(
                  //           'Login as a ',
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         alignment: Alignment.centerRight,
                  //         child: InkWell(
                  //           onTap: () async {
                  //             await Settings.setIsGuest(true);
                  //             Navigator.pushNamedAndRemoveUntil(
                  //                 context, '/UserScreen', (route) => false);
                  //           },
                  //           child: Text(
                  //             'Guest',
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: AppColors.primaryButtonColor),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          )),
    );
  }

  void _countryCodeChange(CountryCode countryCode) {
    String phoneNumber = countryCode.toString();
    setState(() {
      currentCountryCode = phoneNumber;
    });

    print('***************');
    print(phoneNumber);
  }

  void onLogInPress() {
    String phone = currentCountryCode! + _phoneNoController.text.trim();
    // String phone = _phoneNoController.text.trim();
    print(phone);

    String password = _passwordController.text.trim();
    String deviceName = Platform.isAndroid ? "android" : "ios";

    if (!Validations.validateString(phone)) {
      Alerts.showMessage(context, "Invalid mobile number");
      return;
    }

    if (!Validations.validateString(password)) {
      Alerts.showMessage(context, "Invalid password number");
      return;
    }

    ApiCalls.login(phone: phone, password: password, deviceName: deviceName)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var token = response.jsonBody['token'];
        await Settings.setAccessToken(token);
        await Settings.setIsGuest(false);
        User user = User.fromJson(response.jsonBody['user']);
        await Settings.setUserRole(user.role);
        user.role == 1
            ? Navigator.pushNamedAndRemoveUntil(
                context, '/UserScreen', (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false);
      } else {
        Alerts.showMessageForResponse(context, response);
      }
    });
  }

  void googleSignIn() {
    _googleSignIn.signIn().then((value) {
      setState(() {
        socialUserName = googleSignInAccount!.displayName;
        socialUserPhotourl = googleSignInAccount!.photoUrl;
        socialUserEmail = googleSignInAccount!.email;
        socialUserId = googleSignInAccount!.id;
        socialUserServerAuthCode = googleSignInAccount!.serverAuthCode;
      });
    });
  }

  void facebookSignIn() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );
    if (result.status == LoginStatus.success) {
      final resultData = await FacebookAuth.i.getUserData();
      
    

      final AccessToken accessToken = result.accessToken!;
    } else {
      print(result.status);
      print(result.message);
    }
  }
}
