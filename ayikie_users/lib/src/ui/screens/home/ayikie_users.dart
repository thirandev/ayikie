import 'dart:convert';

import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/banner.dart';
import 'package:ayikie_users/src/ui/screens/categories_screen/categories_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/popular_screen/popular_screen.dart';
import 'package:ayikie_users/src/ui/screens/recommanded_for_you/recommanded_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../drawer_screen/drawer_screen.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool _isLoading = true;

  List<Banners> bannerList = [];

  @override
  void initState() {
    super.initState();
    _getBanners();
    _getCategories();
  }

  void _getBanners() async {
    await ApiCalls.getBanners().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody[0]);
        var imageList = response.jsonBody;
        for (var img in imageList) {
          Banners banner = Banners.fromJson(img);
          bannerList.add(banner);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _getCategories() async {
    await ApiCalls.getAllServiceCategory().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  final controller = PageController(
    viewportFraction: 1,
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _isLoading
            ? Center(
                child: ProgressView(),
              )
            : SingleChildScrollView(
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
                                itemCount: bannerList.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              alignment:
                                                  AlignmentDirectional.center),
                                        ),
                                      ),
                                      imageUrl:
                                          bannerList[index].getBannerUrl(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'asserts/images/ayikie_logo.png',
                                        fit: BoxFit.fitHeight,
                                      ),
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
                              count: bannerList.length,
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
                                onTap: () {
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                onTap: () {
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
                                  Column(
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
                              ),
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
                                onTap: () {
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
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.textFieldBackground,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 120,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      40) /
                                                  3,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    topLeft: Radius.circular(8),
                                                  ),
                                                  child: Image.asset(
                                                    'asserts/images/chair.jpg',
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        56) *
                                                    1.8 /
                                                    3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
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
                                    )),
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
