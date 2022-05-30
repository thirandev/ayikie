import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/validations.dart';
import 'package:flutter/material.dart';

import '../home/ayikie_users.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Support',
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
      //endDrawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Full Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              CustomFormField(
                controller: _fullNameController,
                hintText: 'Enter your full name',
                inputType: TextInputType.text,
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              CustomFormField(
                controller: _emailController,
                hintText: 'Enter your email',
                inputType: TextInputType.emailAddress,
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 20, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Message',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                height: 150,
                child: TextField(
                  maxLines: 9,
                  controller: _messageController,
                  decoration: InputDecoration(
                      hintText: "Enter a message",
                      fillColor: AppColors.textFieldBackground,
                      filled: true,
                      hintStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        top: 30,
                      )),
                ),
              ),
              SizedBox(height: 40),
              PrimaryButton(
                  text: 'Send', fontSize: 12, clickCallback: sendRequest),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void sendRequest() {
    String name = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String message = _messageController.text.trim();

    if (!Validations.validateString(name) ||
        !Validations.validateString(message)) {
      Alerts.showMessage(context, "Please enter the fields");
      return;
    }

    if (!Validations.validateEmail(email)) {
      Alerts.showMessage(context, "Please valid email");
      return;
    }

    ApiCalls.vistorSupport(email: email, message: message, name: name)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(
            context, response.jsonBody['success']['message'].toString(),
            title: "Hurrah!",
            onCloseCallback: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UserHomeScreen();
                    }),
                  )
                });
      } else {
        Alerts.showMessageForResponse(context, response);
      }
    });
  }
}
