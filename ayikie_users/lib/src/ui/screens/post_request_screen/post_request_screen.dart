import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/create_request.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/my_offers.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<PostRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Post a Request',
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
      endDrawer: DrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) =>
                          PostRequestTile()),
                ),
                SizedBox(height: 20,),
                PrimaryButton(text: 'Post a Request', clickCallback: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CreaterequestScreen();
                          }),
                        );}),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostRequestTile extends StatelessWidget {
  const PostRequestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return MyOffersScreen();
                              }),
                            );
        
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryPinkColor),
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'March 2022 23',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Active',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Looking for a Pumbler for pipe repair',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Amount :',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Text(
                        '\$25',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Duration :',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Text(
                        '2 days',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Location :',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Text(
                        'Colombo',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '8 oreders submit',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Icon(Icons.edit),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.delete)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
