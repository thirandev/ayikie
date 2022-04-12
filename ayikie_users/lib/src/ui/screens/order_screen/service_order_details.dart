import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ServiceOrderDetails extends StatefulWidget {
  const ServiceOrderDetails({Key? key}) : super(key: key);

  @override
  _ServiceOrderDetailsState createState() => _ServiceOrderDetailsState();
}

class _ServiceOrderDetailsState extends State<ServiceOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            'My Orders',
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
        body: 
             SizedBox(
               height: MediaQuery.of(context).size.height ,
               child: Container(
                 padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                 child: Column(
                   mainAxisSize: MainAxisSize.max,
                   children: [
                    SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 100),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    isFirst: true,
                    indicatorStyle: IndicatorStyle(
                      height: 40,
                      color: Colors.purple,
                      padding: const EdgeInsets.all(8),
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.insert_emoticon,
                      ),
                    ),
                    startChild: Container(
                      constraints: const BoxConstraints(
                        minWidth: 120,
                      ),
                      color: Colors.amberAccent,
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    isLast: true,
                    indicatorStyle: IndicatorStyle(
                      height: 30,
                      color: Colors.red,
                      indicatorXY: 0.7,
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.thumb_up,
                      ),
                    ),
                    endChild: Container(
                      constraints: const BoxConstraints(
                        minWidth: 80,
                      ),
                      color: Colors.lightGreenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
                   ],
                 ),
               ),
             ),
          
      ),
    );
  }
}
