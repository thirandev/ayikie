import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/order_screen/service_order_details.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderLandingScreen extends StatefulWidget {
  const OrderLandingScreen({Key? key}) : super(key: key);

  @override
  _OrderLandingScreenState createState() => _OrderLandingScreenState();
}

class _OrderLandingScreenState extends State<OrderLandingScreen> {
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
                    OrderTileWidget(),
                    OrderTileWidget(),
                    OrderTileWidget()
                   ],
                 ),
               ),
             ),
          
      ),
    );
  }
}

class OrderTileWidget extends StatelessWidget {
  const OrderTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //  Navigator.push(
        //                   context,
        //                   MaterialPageRoute(builder: (context) {
        //                     return ServiceOrderDetails();
                           
        //                   }),
        //                 );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
              color: AppColors.textFieldBackground,
              borderRadius: BorderRadius.all(
                  Radius.circular(8))),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: (MediaQuery.of(context).size.width- 40)/3,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                    child: Image.asset(
                      'asserts/images/worker.jpg',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: (MediaQuery.of(context).size.width- 56)*1.8/3,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                        
                    children: [
                      Text(
                        'Praneeth Rajapaksha',
                        
                        style: TextStyle(
                            fontWeight:
                                FontWeight.w900),
                      ),
                      SizedBox(height: 20,),
                      Row(children: [
                        Text('Order Amount :'),
                        Spacer(),
                        Text('\$25',style: TextStyle(fontWeight: FontWeight.w900),),
                      ],),
                      SizedBox(height: 5,),
                      Row(children: [
                        Text('Order Date : '),
                        Spacer(),
                        Text('2022-02-35',style: TextStyle(fontWeight: FontWeight.w900),),
                      ],),
                      SizedBox(height: 10,),
                      Row(children: [
                        
                        Spacer(),
                        Text('pending order')
                      ],)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

