import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/ui/widgets/custom_form_field.dart';
import 'package:ayikie_main/src/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _value = 0;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Image.asset('asserts/images/ayikie_logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Your role',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => setState(() => _value = 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: _value == 0
                                  ? AppColors.primaryButtonColor
                                  : Colors.transparent,
                              border: Border.all(color: AppColors.black)),
                          height: 150,
                          width: 120,
                          child: SvgPicture.asset('asserts/images/user.svg'),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => setState(() => _value = 1),
                        child: Container(
                          height: 100,
                          width: 100,
                          color: _value == 1 ? Colors.grey : Colors.transparent,
                          child: SvgPicture.asset(
                              'asserts/images/professional.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
                  hintText: 'Enter your phone no here',
                  inputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
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
                  controller: _phoneNoController,
                  hintText: 'Enter your password here',
                  inputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
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
                          onTap: () {},
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
                PrimaryButton(text: 'Log In', clickCallback: () {})
              ],
            ),
          ),
        ));
  }
}
