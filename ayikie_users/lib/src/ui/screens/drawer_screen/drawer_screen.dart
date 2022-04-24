import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/ui/screens/invite_friends_screen/invite_friends_screen.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/post_request_screen.dart';
import 'package:ayikie_users/src/ui/screens/privacy_policies_screen/privacy_policies_screen.dart';
import 'package:ayikie_users/src/ui/screens/settings_screen/settings_screen.dart';
import 'package:ayikie_users/src/ui/screens/support_screen/support_screen.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/verification_center_screen.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/settings.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  bool isGuest = true;

  @override
  void initState() {
    super.initState();
    _checkIsGuest();
  }

  _checkIsGuest() async {
    var guest = await Settings.getIsGuest()??false;
    setState(() {
      isGuest = guest;
    });
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //alignment: Alignment.center,
                child: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              Container(
                alignment: Alignment.center,
                height: 65,
                child: Image.asset('asserts/images/drawer_logo.png'),
              ),
            ],
          ),
          isGuest?SizedBox(
            width: width,
            child: Container(
              color: Colors.grey[300],
              padding: EdgeInsets.only(left: 15,top:20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primaryButtonColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login account or create new one for free",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        PrimaryButton(
                            buttonWidth: width/3.5,
                            buttonHeight: 40,
                            text: "Login",
                            fontSize: 16,
                            clickCallback: (){
                              Navigator.pushNamed(
                                  context, '/LoginScreen');
                            },
                          prexIcon: Icon(
                            Icons.logout,
                            color: AppColors.white,
                            size: 20,
                          ),

                        ),
                        SizedBox(
                          width: 10,
                        ),
                        PrimaryButton(
                            buttonWidth: width/3,
                            buttonHeight: 40,
                            text: "Register",
                            bgColor: AppColors.white,
                            textColor: AppColors.primaryButtonColor,
                            fontSize: 16,
                            prexIcon: Icon(
                              Icons.assignment_ind,
                              color: AppColors.primaryButtonColor,
                              size: 20,
                            ),
                            clickCallback: (){
                              Navigator.pushNamed(
                                  context, '/RegistrationScreen');
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ):Container(),
          DrawerWidget(
            title: 'Verification Center',
            imagePath: 'asserts/icons/verification_center.png',
            onPress: () {
              if(isGuest){
                Alerts.showGuestMessage(context);
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return VerificationCenter();
                }),
              );
            },
          ),
          DrawerWidget(
            title: 'Invite Friends',
            imagePath: 'asserts/icons/invite_friends.png',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return InviteFriendsScreen();
                }),
              );
            },
          ),
          DrawerWidget(
            title: 'Settings',
            imagePath: 'asserts/icons/settings.png',
            onPress: () {
              if(isGuest){
                Alerts.showGuestMessage(context);
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SettingsScreen();
                }),
              );
            },
          ),
          DrawerWidget(
            title: 'Post a Request',
            imagePath: 'asserts/icons/post_a_request.png',
            onPress: () {
              if(isGuest){
                Alerts.showGuestMessage(context);
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PostRequestScreen();
                }),
              );
            },
          ),
          DrawerWidget(
            title: 'Chat',
            imagePath: 'asserts/icons/chat.png',
            onPress: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     return InviteFriendsScreen();
              //   }),
              // );
            },
          ),
          DrawerWidget(
            title: 'Support',
            imagePath: 'asserts/icons/support.png',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SupportScreen();
                }),
              );
            },
          ),
          DrawerWidget(
            title: 'Privacy Policies',
            imagePath: 'asserts/icons/privacy_policies.png',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PrivacyPoliciesScreen();
                }),
              );
            },
          ),
          DrawerWidget(
            title: 'Log Out',
            imagePath: 'asserts/icons/logout.png',
            onPress: () async {
              if(isGuest){
                Alerts.showGuestMessage(context);
                return;
              }
              final response = await ApiCalls.userLogOut();
              if (response.isSuccess) {
                await Settings.setAccessToken("");
                Navigator.pushNamedAndRemoveUntil(
                    context, '/LoginScreen', (route) => false);
              } else {
                print('Opps');
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final Function onPress;
  const DrawerWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      highlightColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 24,
              height: 24,
              child: Image.asset(
                imagePath,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
