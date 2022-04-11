import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/popular_screen/popular_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'src/ui/screens/categories_screen/categories_screen.dart';
import 'src/ui/screens/drawer_screen/drawer_screen.dart';
import 'src/ui/screens/recommanded_for_you/recommanded_screen.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List<String> images = [
    'asserts/images/caresol.jpg',
    'asserts/images/worker.jpg',
    'asserts/images/caresol.jpg',
    'asserts/images/caresol.jpg'
  ];
  final controller = PageController(
    viewportFraction: 1,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: Image.asset('asserts/images/drawer_logo.png'),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.textFieldBackground,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Search here',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryButtonColor),
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: AppColors.primaryButtonColor,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 175,
                        child: PageView.builder(
                          controller: controller,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                images[index],
                                height: 175,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: images.length,
                        effect: const WormEffect(
                          dotWidth: 5,
                          dotHeight: 5,
                          dotColor: AppColors.black,
                          activeDotColor: AppColors.primaryButtonColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w900),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CategoriesScreen();
                            }),
                          );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryButtonColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 15,
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryButtonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SvgPicture.asset(
                                    'asserts/images/categories.svg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Life Style',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryButtonColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Recommand for you',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w900),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                             Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return RecommandedScreen();
                            }),
                          );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryButtonColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 15,
                        itemBuilder: (BuildContext context, int index) =>
                            RecommandWidget(),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Popular',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w900),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return PopularScreen();
                            }),
                          );

                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryButtonColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) =>
                              PopularWidget()),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecommandWidget extends StatelessWidget {
  const RecommandWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                          children: [
    Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.primaryButtonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
          child: Image.asset(
            'asserts/images/chair.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: AppColors.textFieldBackground,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)),
      ),
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Classic Chair',
              style: TextStyle(
                  fontWeight: FontWeight.w900),
            ),
            Text(
                'Best Production on sale in sri lanka',
                style: TextStyle(fontSize: 12)),
            Text(
              '\$25.99',
              style: TextStyle(
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    )
                          ],
                        );
  }
}

class PopularWidget extends StatelessWidget {
  const PopularWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    'asserts/images/chair.jpg',
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Best pumbler in Sri lanka ',
                      
                      style: TextStyle(
                          fontWeight:
                              FontWeight.w900),
                    ),
                    Text(
                        'I offer best prise plan and the highly productive service for your side'),
                    Text(
                      '\$10.00 / hr',
                      style: TextStyle(
                          fontWeight:
                              FontWeight.w900),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
