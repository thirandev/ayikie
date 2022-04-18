import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.black),
      backgroundColor: AppColors.white,
      elevation: 0,
      title: title=="Home"?Container(
        alignment: Alignment.bottomLeft,
        height: 50,
        child: Image.asset('asserts/images/drawer_logo.png'),
      ):Text(
        title,
        style: TextStyle(color: Colors.black),
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
                      Alerts.showGuestMessage(context);
                      return;
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) {
                      //     return NotificationScreen();
                      //   }),
                      // );
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
    );
  }
}