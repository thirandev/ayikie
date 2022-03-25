import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/ui/screens/auth/login_screen.dart';
import 'package:ayikie_main/src/ui/screens/auth/send_otp_screen.dart';
import 'package:ayikie_main/src/ui/widgets/custom_form_field.dart';
import 'package:ayikie_main/src/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _value = 0;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

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
                  child:
                      SvgPicture.asset('asserts/images/registration_logo.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Registration',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Full Name',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                CustomFormField(
                  controller: _nameController,
                  hintText: 'full name',
                  inputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Phone No',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                CustomFormField(
                  controller: _confirmPasswordController,
                  hintText: 'confirm password',
                  inputType: TextInputType.text,
                  isObsucure: true,
                ),
                SizedBox(height: 40),
                PrimaryButton(
                    text: 'Register',
                    fontSize: 12,
                    clickCallback: () {
                      Navigator.pushNamed(context, '/SendOtpScreen');
                    }),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, ),
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
        ));
  }
}
