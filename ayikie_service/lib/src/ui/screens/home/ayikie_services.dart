import 'dart:convert';

import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/Item.dart';
import 'package:ayikie_service/src/models/banner.dart';
import 'package:ayikie_service/src/models/images.dart';
import 'package:ayikie_service/src/models/service.dart';

import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/my_items/my_items_screen.dart';
import 'package:ayikie_service/src/ui/screens/my_order/my_order_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';

import 'package:ayikie_service/src/ui/screens/profile/profile.dart';
import 'package:ayikie_service/src/ui/widget/custom_app_bar.dart';

import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ServicesHomeScreen extends StatefulWidget {
  @override
  _ServicesHomeScreenState createState() => _ServicesHomeScreenState();
}

class _ServicesHomeScreenState extends State<ServicesHomeScreen> {
  List<Images> banners = [];
  List<Item> categories = [];
  List<Service> recommandedServices = [];
  List<Service> popularServices = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getBanners();
  }

  void _getBanners() async {
    await ApiCalls.getBanners().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        setState(() {
          _isLoading = false;
        });
        var imageList = response.jsonBody;
        print('********************************');
        for (var img in imageList) {
          Images banner = Banners.fromJson(img);
          banners.add(banner);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }

      // _getCategories();
    });
  }

  // void _getCategories() async {
  //   await ApiCalls.getAllServiceCategory().then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     if (response.isSuccess) {
  //       print(response.jsonBody);
  //       var data = response.jsonBody;
  //       for (var item in data) {
  //         Item category = Item.fromJson(item);
  //         categories.add(category);
  //       }
  //     } else {
  //       Alerts.showMessage(context, "Something went wrong. Please try again.",
  //           title: "Oops!");
  //     }
  //     _getRecommandations();
  //   });
  // }

  // void _getRecommandations() async {
  //   await ApiCalls.getRecommendedServices().then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     if (response.isSuccess) {
  //       print(response.jsonBody);
  //       var data = response.jsonBody;
  //       for (var item in data) {
  //         Service recommand = Service.fromJson(item);
  //         recommandedServices.add(recommand);
  //       }
  //     } else {
  //       Alerts.showMessage(context, "Something went wrong. Please try again.",
  //           title: "Oops!");
  //     }
  //     _getPopularItems();
  //   });
  // }

  // void _getPopularItems() async {
  //   await ApiCalls.getPopularServices().then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     if (response.isSuccess) {
  //       print(response.jsonBody);
  //       var data = response.jsonBody;
  //       for (var item in data) {
  //         Service popular = Service.fromJson(item);
  //         popularServices.add(popular);
  //       }
  //     } else {
  //       Alerts.showMessage(context, "Something went wrong. Please try again.",
  //           title: "Oops!");
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

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
                                itemCount: banners.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              alignment:
                                                  AlignmentDirectional.center),
                                        ),
                                      ),
                                      imageUrl: banners[index].getBannerUrl(),
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
                              count: 4, //banners.length,
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
                                'My Items',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w900),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MyItemsScreen();
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
                                itemCount: popularServices.length > 10
                                    ? 10
                                    : popularServices.length,
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
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  topLeft: Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.scaleDown,
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .center),
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      popularServices[index]
                                                          .image!
                                                          .getBannerUrl(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'asserts/images/ayikie_logo.png',
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ),
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
                                                      popularServices[index]
                                                          .name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    Text(popularServices[index]
                                                        .introduction),
                                                    Text(
                                                      '\$${popularServices[index].price}',
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
