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
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _value = 1;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  

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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w900),
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
                      padding: const EdgeInsets.only( bottom: 20),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryButtonColor.withOpacity(.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 4,right: 4),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10,top: 10),
                                child:
                                  Text(
                                    'Please select trade role',
                                    style: TextStyle(
                                      color: AppColors.black,
                                        fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                              ),
                              SizedBox(height: 10),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 80,
                                    width:(MediaQuery.of(context).size.width - 80 ) / 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('BUYER',style: TextStyle(fontWeight: FontWeight.w700),),
                                              Spacer(),
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Radio<int>(
                                                  value: 1,
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
                                          SizedBox(height: 5,),
                                          Text(
                                              'I am abuying a \n product or service'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width:(MediaQuery.of(context).size.width - 80 ) / 2,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                       
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('SELLER',style: TextStyle(fontWeight: FontWeight.w700),),
                                              Spacer(),
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Radio<int>(
                                                  value: 2,
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
                                          SizedBox(height: 5,),
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
                            fontSize: 16, fontWeight: FontWeight.w700),
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
                        onPressed: () {},
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
                        onPressed: () {},
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

  void onLogInPress() {


    String phone = _phoneNoController.text.trim();
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
        user.role==1?
          Navigator.pushNamedAndRemoveUntil(
              context, '/UserScreen', (route) => false):
        Navigator.pushNamedAndRemoveUntil(
            context, '/ServiceScreen', (route) => false);
      } else {
        Alerts.showMessageForResponse(context, response);
      }
    });
  }
}
