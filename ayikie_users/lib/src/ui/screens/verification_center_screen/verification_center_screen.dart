import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/user.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/address_verification.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/credit_card__verification.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/email_verification.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/facebook_verification.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/id_verification.dart';
import 'package:ayikie_users/src/ui/screens/verification_center_screen/linkedin_verification.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:flutter/material.dart';

class VerificationCenter extends StatefulWidget {
  const VerificationCenter({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<VerificationCenter> {
  bool _isLoading = true;
  late User _user;
  List<int> isVerified = [];

  @override
  void initState() {
    // TODO: implement initState
    _getUserData();
    super.initState();
  }

  void _getUserData() async {
    await ApiCalls.getUser().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        _user = User.fromJson(response.jsonBody);
        setState(() {
          isVerified = _user.getVerifiedList();
          print(isVerified);
        });
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Verification Center',
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
                    SizedBox(
                      width: 10,
                    ),
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
      endDrawer: DrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: _isLoading
                ? Center(
                    child: ProgressView(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ItemRowWidget(
                          isVerified: isVerified[0] != 0,
                          name: 'Email Verification',
                          imageUrl: 'asserts/icons/support.png',
                          onPress: () {
                            isVerified[0] != 1
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return EmailVerification();
                                    }),
                                  )
                                : null;
                          }),
                      Divider(
                        thickness: 1,
                      ),
                      ItemRowWidget(
                        name: 'Facebook Verification',
                        isVerified: isVerified[1] != 0,
                        imageUrl: 'asserts/icons/facebook.png',
                        onPress: () {
                          isVerified[1] != 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return FbVerification();
                                  }),
                                )
                              : null;
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ItemRowWidget(
                        name: 'LinkedIn Verification',
                        isVerified: isVerified[2] != 0,
                        imageUrl: 'asserts/icons/linkedin.png',
                        onPress: () {
                          isVerified[2] != 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return LinkedinVerification();
                                  }),
                                )
                              : null;
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ItemRowWidget(
                        name: 'Credit Card Verification',
                        isVerified: isVerified[3] != 0,
                        imageUrl: 'asserts/icons/credit_card.png',
                        onPress: () {
                          isVerified[3] != 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return CreditCardVerification();
                                  }),
                                )
                              : null;
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ItemRowWidget(
                        name: 'Address Verification',
                        isVerified: isVerified[4] != 0,
                        imageUrl: 'asserts/icons/address.png',
                        onPress: () {
                          isVerified[4] != 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddressVerification();
                                  }),
                                )
                              : null;
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ItemRowWidget(
                        name: 'ID Verification',
                        isVerified: isVerified[5] != 0,
                        imageUrl: 'asserts/icons/id.png',
                        onPress: () {
                          isVerified[5] != 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return idVerification();
                                  }),
                                )
                              : null;
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ItemRowWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isVerified;
  final Function onPress;
  const ItemRowWidget({
    Key? key,
    required this.name,
    required this.isVerified,
    required this.imageUrl,
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
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 24,
              height: 24,
              child: Image.asset(
                imageUrl,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            new Spacer(),
            isVerified
                ? Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  )
                : Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
