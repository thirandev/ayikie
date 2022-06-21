import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Notification',
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
                child: Container(
                  width: 26,
                  height: 26,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(180 / 360),
                    child: Image.asset(
                      'asserts/icons/menu.png',
                      scale: 10,
                    ),
                  ),
                  // Image(
                  //   image: Images.getImage('assets/icons/menu.png'),
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    NotificationTileWidget(),
                    NotificationTileWidget(),
                    NotificationTileWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.0,
                backgroundColor: AppColors.redColor,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 7.5, top: 7.5),
                child: Text(
                  'Item delivered Successfully',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 7.5),
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  'Your order have successfully delevired by the serive provider.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 10),
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  '2022/02/23',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 25, bottom: 5),
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  'a day ago       10.35 am',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.divider,
          ),
        ],
      ),
    );
  }
}
