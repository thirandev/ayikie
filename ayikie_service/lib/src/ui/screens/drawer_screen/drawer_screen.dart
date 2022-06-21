import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/ui/screens/buyer_request/buyer_request.dart';
import 'package:ayikie_service/src/ui/screens/invite_friends_screen/invite_friends_screen.dart';
import 'package:ayikie_service/src/ui/screens/my_reviews/my_reviews.dart';
import 'package:ayikie_service/src/ui/screens/privacy_policies_screen/cookies_policies.dart';

import 'package:ayikie_service/src/ui/screens/privacy_policies_screen/privacy_policies_screen.dart';
import 'package:ayikie_service/src/ui/screens/privacy_policies_screen/terms_and_conditions.dart';
import 'package:ayikie_service/src/ui/screens/settings_screen/settings_screen.dart';
import 'package:ayikie_service/src/ui/screens/support_screen/support_screen.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/verification_center_screen.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/settings.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  late bool isGuest;

  @override
  void initState() {
    super.initState();
  // _checkIsGuest();
  }

  // _checkIsGuest() async {
  //   isGuest = await Settings.getIsGuest()??false;
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
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
            DrawerWidget(
              title: 'Verification Center',
              imagePath: 'asserts/icons/verification_center.png',
              onPress: () {
                // if(isGuest){
                //   Alerts.showGuestMessage(context);
                //   return;
                // }
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
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SettingsScreen();
                  }),
                );
              },
            ),
            DrawerWidget(
              title: 'Buyer Requests',
              imagePath: 'asserts/icons/post_a_request.png',
              onPress: () {
               
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return BuyerRequestScreen();
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
              title: 'My Reviews',
              imagePath: 'asserts/icons/review.png',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MyReviewsScreen();
                  }),
                );
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
              imagePath: 'asserts/icons/privacy.png',
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
              title: 'Cookies Policies',
              imagePath: 'asserts/icons/cookies.png',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CookiesPoliciesScreen();
                  }),
                );
              },
            ),
            DrawerWidget(
              title: 'Terms and Conditions',
              imagePath: 'asserts/icons/privacy_policies.png',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return TermsAndConditionScreen();
                  }),
                );
              },
            ),
            DrawerWidget(
              title: 'Log Out',
              imagePath: 'asserts/icons/logout.png',
              onPress: () async {
                
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
