import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/address_verification.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/credit_card__verification.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/email_verification.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/facebook_verification.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/id_verification.dart';
import 'package:ayikie_service/src/ui/screens/verification_center_screen/linkedin_verification.dart';
import 'package:flutter/material.dart';

class VerificationCenter extends StatefulWidget {
  const VerificationCenter({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<VerificationCenter> {
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
      body:  SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ItemRowWidget(
                      name: 'Email Verification',
                      imageUrl: 'asserts/icons/support.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return EmailVerification();
                          }),
                        );
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'Facebook Verification',
                      imageUrl: 'asserts/icons/facebook.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return FbVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'LinkedIn Verification',
                      imageUrl: 'asserts/icons/linkedin.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return LinkedinVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'Credit Card Verification',
                      imageUrl: 'asserts/icons/credit_card.png',
                      onPress: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CreditCardVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'Address Verification',
                      imageUrl: 'asserts/icons/address.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return AddressVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'Company Registration',
                      imageUrl: 'asserts/icons/building.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return idVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'Tax Certificate',
                      imageUrl: 'asserts/icons/tax.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return idVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'Skill Certificates',
                      imageUrl: 'asserts/icons/skills.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return idVerification();
                          }),
                        );
                        
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ItemRowWidget(
                      name: 'ID Verification',
                      imageUrl: 'asserts/icons/id.png',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return idVerification();
                          }),
                        );
                        
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
  final Function onPress;
  const ItemRowWidget({
    Key? key,
    required this.name,
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
        margin: EdgeInsets.only(top: 10,bottom: 10),
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
            Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}