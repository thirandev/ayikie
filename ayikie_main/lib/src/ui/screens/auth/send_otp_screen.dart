import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/ui/widgets/primary_button.dart';
import 'package:ayikie_users/ayikie_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  _SendOtpScreenState createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  String _otp = "";
  TextEditingController _otpController = TextEditingController();

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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: SvgPicture.asset('asserts/images/two_factor_logo.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Container(
                      child: Text(
                    'Check your  Phone',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter the verification code we just sent you on your mobile phone ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter your OTP',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: PinCodeTextField(
                            appContext: context,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                borderWidth: 0.5,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 40,
                                fieldWidth: 40,
                                selectedColor: AppColors.transparent,
                                activeColor: AppColors.transparent,
                                inactiveColor: AppColors.transparent,
                                selectedFillColor:
                                    AppColors.textFieldBackground,
                                activeFillColor: AppColors.textFieldBackground,
                                inactiveFillColor:
                                    AppColors.textFieldBackground,
                                fieldOuterPadding: EdgeInsets.only(right: 8)),
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
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    PrimaryButton(
                        text: 'Verify',
                        clickCallback: () {
                          Navigator.pushNamedAndRemoveUntil(
            context, '/UserScreen', (route) => false);
                          
                        }),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100, top: 20),
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
                                    color: AppColors.primaryButtonColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
