import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/Item.dart';
import 'package:ayikie_users/src/models/banner.dart';
import 'package:ayikie_users/src/models/images.dart';
import 'package:ayikie_users/src/models/service.dart';
import 'package:ayikie_users/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_users/src/ui/screens/categories_screen/categories_screen.dart';
import 'package:ayikie_users/src/ui/screens/popular_screen/popular_screen.dart';
import 'package:ayikie_users/src/ui/screens/recommanded_for_you/recommanded_screen.dart';
import 'package:ayikie_users/src/ui/screens/sub_categories_screen/sub_product_screen.dart';
import 'package:ayikie_users/src/ui/screens/sub_categories_screen/sub_service_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool _isLoading = true;

  List<Images> banners = [];
  List<Item> categories = [];
  List<Service> recommandedServices = [];
  List<Service> popularServices = [];

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
        var imageList = response.jsonBody;
        for (var img in imageList) {
          Images banner = Banners.fromJson(img);
          banners.add(banner);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getCategories();
    });
  }

  void _getCategories() async {
    await ApiCalls.getAllServiceCategory(page: 1).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Item category = Item.fromJson(item);
          categories.add(category);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getRecommandations();
    });
  }

  void _getRecommandations() async {
    await ApiCalls.getRecommendedServices(page: 1).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Service recommand = Service.fromJson(item);
          recommandedServices.add(recommand);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getPopularItems();
    });
  }

  void _getPopularItems() async {
    await ApiCalls.getPopularServices(page: 1).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Service popular = Service.fromJson(item);
          popularServices.add(popular);
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
                                itemCount: banners.length,
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
                              count: banners.length,
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
                            height: 120,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  categories.length > 8 ? 8 : categories.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return SubSeriveScreen(
                                          categoryId: categories[index].id);
                                    }),
                                  );
                                },
                                child: Container(
                                  width: 90,
                                  child: Column(
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
                                          child: CachedNetworkImage(
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center),
                                              ),
                                            ),
                                            imageUrl: categories[index]
                                                .image!
                                                .getBannerUrl(),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                              'asserts/images/ayikie_logo.png',
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        categories[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                              itemCount: recommandedServices.length > 10
                                  ? 10
                                  : recommandedServices.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ServiceScreen(
                                          serviceId:
                                              recommandedServices[index].id);
                                    }),
                                  );
                                },
                                child: Column(
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
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          child: CachedNetworkImage(
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center),
                                              ),
                                            ),
                                            imageUrl: recommandedServices[index]
                                                .image!
                                                .getBannerUrl(),
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'asserts/images/ayikie_logo.png',
                                              fit: BoxFit.fitHeight,
                                            ),
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
                                              recommandedServices[index].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            Text(
                                                recommandedServices[index]
                                                    .introduction,
                                                style: TextStyle(fontSize: 12)),
                                            Text(
                                              '\$${recommandedServices[index].price}',
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
                                itemCount: popularServices.length > 10
                                    ? 10
                                    : popularServices.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return ServiceScreen(
                                                serviceId:
                                                    popularServices[index].id);
                                          }),
                                        );
                                      },
                                      child: Padding(
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
                                                  child: CachedNetworkImage(
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        popularServices[index]
                                                            .name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      Text(
                                                          popularServices[index]
                                                              .introduction),
                                                      Text(
                                                        '\$${popularServices[index].price}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                          SizedBox(
                            height: 40,
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
