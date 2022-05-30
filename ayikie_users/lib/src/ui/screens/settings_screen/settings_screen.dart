import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<SettingsScreen> {
  bool pushNotification = false;
  bool smsNotification = false;
  bool emailNotification = false;
  bool tfauthentication = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Settings',
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
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              //  Divider(thickness: 1,),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                 
                  title: Row(
                    children: [
                      Icon(Icons.notifications_none),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Push Notification',
                        style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.black),
                      ),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                           Text('Push Notifications',style: TextStyle(fontWeight: FontWeight.w500),),
                           Spacer(),
                          Text(pushNotification ? 'On' : 'Off'),
                          SizedBox(width: 20,),
                          Container(
                            child: FlutterSwitch(
                              width: 42.5,
                              height: 22.5,
                              
                              value: pushNotification,
                              toggleSize: 25,
                              padding: 1,
                              onToggle: (value) {
                                setState(() {
                                  pushNotification = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.shield_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Two Factor Authentication',
                        style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.black),
                      ),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                           Text('Two Factor Authentication',style: TextStyle(fontWeight: FontWeight.w500),),
                           Spacer(),
                          Text(tfauthentication ? 'On' : 'Off'),
                          SizedBox(width: 20,),
                          Container(
                            child: FlutterSwitch(
                              width: 42.5,
                              height: 22.5,
                              
                              value: tfauthentication,
                              toggleSize: 25,
                              padding: 1,
                              onToggle: (value) {
                                setState(() {
                                  tfauthentication = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.messenger_outline),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'SMS Notification',
                        style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.black),
                      ),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                           Text('SMS Notifications',style: TextStyle(fontWeight: FontWeight.w500),),
                           Spacer(),
                          Text(smsNotification ? 'On' : 'Off'),
                          SizedBox(width: 20,),
                          Container(
                            child: FlutterSwitch(
                              width: 42.5,
                              height: 22.5,
                              
                              value: smsNotification,
                              toggleSize: 25,
                              padding: 1,
                              onToggle: (value) {
                                setState(() {
                                  smsNotification = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Email Notification',
                       style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.black),
                      ),
                    ],
                  ),
                  children: [
                   ListTile(
                      title: Row(
                        children: [
                           Text('Email Notifications',style: TextStyle(fontWeight: FontWeight.w500),),
                           Spacer(),
                          Text(emailNotification ? 'On' : 'Off'),
                          SizedBox(width: 20,),
                          Container(
                            child: FlutterSwitch(
                              width: 42.5,
                              height: 22.5,
                              
                              value: emailNotification,
                              toggleSize: 25,
                              padding: 1,
                              onToggle: (value) {
                                setState(() {
                                  emailNotification = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
