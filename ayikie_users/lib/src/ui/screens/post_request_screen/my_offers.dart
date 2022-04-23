import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/create_request.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOffersScreen extends StatefulWidget {
  const MyOffersScreen({Key? key}) : super(key: key);

  @override
  _MyOffersScreenState createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'My Offers',
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
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) =>
                          CommentWidget()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.textFieldBackground),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SvgPicture.asset(
                        'asserts/images/profile.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Jane Perera',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout'),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Order Amount :',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
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
                  new IconButton(
                    icon: new Icon(
                      Icons.call_outlined,
                      color: AppColors.black,
                    ),
                    onPressed: () {},
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.chat_bubble_outline_sharp,
                      color: AppColors.black,
                    ),
                    onPressed: () {},
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 130,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryButtonColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Accept Offer',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}

class PostRequestTile extends StatelessWidget {
  const PostRequestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
