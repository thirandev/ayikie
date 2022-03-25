import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/ui/screens/auth/login_screen.dart';
import 'package:ayikie_main/src/ui/widgets/custom_form_field.dart';
import 'package:ayikie_main/src/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String _otp = "";
  bool _isPhoneNoWidget = true;
  bool _isOtpWidget = false;
  bool _isPasswordWidget = false;
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  onChangePin(String value) {
    setState(() {
      _otp = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  child: SvgPicture.asset('asserts/images/forget_password.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Container(
                    alignment: Alignment.center,
                      child: _isPhoneNoWidget
                          ? Text(
                              'Forget My Password',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.start,
                            )
                          : _isOtpWidget
                              ? Text(
                                  'Check Your Phone',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.start,
                                )
                              : Text(
                                  'Create New Password',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.start,
                                )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.center,
                    child: _isPhoneNoWidget
                        ? Text(
                            'Enter the mobile phone no associated with your account',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : _isOtpWidget
                            ? Text(
                                'Enter the verification code we just sent you on your mobile phone   ',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Your new password must be diffrent from previous used passwords  ',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                  ),
                ),
                _isPhoneNoWidget
                    ? Column(
                        children: [
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
                        ],
                      )
                    : _isOtpWidget
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Enter your OTP',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: PinCodeTextField(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      appContext: context,
                                      length: 6,
                                      cursorHeight: 15,
                                      cursorWidth: 1.5,
                                      enablePinAutofill: true,
                                      autoDismissKeyboard: false,
                                      autoFocus: false,
                                      obscureText: false,
                                      animationType: AnimationType.fade,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderWidth: 0,
                                        borderRadius: BorderRadius.circular(8),
                                        fieldOuterPadding: EdgeInsets.only(right: 8),
                                        fieldHeight: 40,
                                        fieldWidth: 40,
                                        selectedColor: AppColors.transparent,
                                        activeColor: AppColors.transparent,
                                        inactiveColor: AppColors.transparent,
                                        selectedFillColor:
                                            AppColors.textFieldBackground,
                                        activeFillColor:
                                            AppColors.textFieldBackground,
                                        inactiveFillColor:
                                            AppColors.textFieldBackground,
                                      ),
                                      cursorColor: Colors.black,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      textStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      enableActiveFill: true,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        onChangePin(value);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'New Password',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              CustomFormField(
                                controller: _newPasswordController,
                                hintText: 'new password',
                                inputType: TextInputType.number,
                                isObsucure: true,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Confirm Password',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              CustomFormField(
                                controller: _confirmPasswordController,
                                hintText: 'comfirm',
                                inputType: TextInputType.number,
                                isObsucure: true,
                              ),
                            ],
                          ),
                SizedBox(height: 40),
                _isPhoneNoWidget
                    ? Column(
                      children: [
                        PrimaryButton(
                          
                            text: 'Send',
                            clickCallback: () {
                              setState(() {
                                _isOtpWidget = true;
                                _isPhoneNoWidget = false;
                              });
                            }),
                            SizedBox(height: 40)
                      ],
                    )
                    : _isOtpWidget
                        ? Column(
                            children: [
                              PrimaryButton(
                                  text: 'Verify',
                                  clickCallback: () {
                                    setState(() {
                                      _isPasswordWidget = true;
                                      _isOtpWidget = false;
                                    });
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          print('resend');
                                        },
                                        child: Text(
                                          'Resend',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColors.primaryButtonColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          )
                        : Column(
                          children: [
                            PrimaryButton(
                                text: 'Confirm',
                                clickCallback: () {
                                  Navigator.pushNamedAndRemoveUntil(
            context, '/LoginScreen', (route) => false);
                                 
                                }),
                                SizedBox(height: 40),
                          ],
                        ),
              ],
            ),
          ),
        ));
  }
}
