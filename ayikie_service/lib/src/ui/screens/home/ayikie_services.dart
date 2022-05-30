import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/Item.dart';
import 'package:ayikie_service/src/models/banner.dart';
import 'package:ayikie_service/src/models/images.dart';
import 'package:ayikie_service/src/models/product.dart';
import 'package:ayikie_service/src/models/service.dart';
import 'package:ayikie_service/src/ui/screens/Item/product_screen.dart';
import 'package:ayikie_service/src/ui/screens/Item/service_screen.dart';

import 'package:ayikie_service/src/ui/screens/my_items/my_items_screen.dart';
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
  List<Product> products = [];
  List<Service> services = [];

  bool _isLoading = true;
  bool _isNoProduct = true;

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
        _getSeriveItems();
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void _getSeriveItems() async {
    await ApiCalls.getSellerSerivces(page: 1).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Service popular = Service.fromJson(item);
          services.add(popular);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      if (services.isEmpty) {
        setState(() {
          _isNoProduct = false;
        });
        _getProductItems();
        return;
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _getProductItems() async {
    await ApiCalls.getSellerProducts(page: 1).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Product popular = Product.fromJson(item);
          products.add(popular);
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
                          products.isEmpty && services.isEmpty
                              ? Center(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'asserts/images/empty.png',
                                          scale: 5,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('No Items Here',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                )
                              : _isNoProduct
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: services.length > 10
                                              ? 10
                                              : services.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                      return ServiceScreen(
                                                          serviceId:
                                                              services[index]
                                                                  .id);
                                                    }),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          bottom: 8.0),
                                                  child: Container(
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .textFieldBackground,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 120,
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  40) /
                                                              3,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              topLeft: Radius
                                                                  .circular(8),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .center),
                                                                ),
                                                              ),
                                                              imageUrl: services[
                                                                      index]
                                                                  .image!
                                                                  .getBannerUrl(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                'asserts/images/ayikie_logo.png',
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: (MediaQuery.of(
                                                                            context)
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
                                                                  services[
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                                Text(services[
                                                                        index]
                                                                    .introduction),
                                                                Text(
                                                                  '\$${services[index].price}',
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
                                    )
                                  : SizedBox(
                                      height: 300,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: products.length > 10
                                              ? 10
                                              : products.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                      return ProductScreen(
                                                          productId:
                                                              products[index]
                                                                  .id);
                                                    }),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          bottom: 8.0),
                                                  child: Container(
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .textFieldBackground,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 120,
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  40) /
                                                              3,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              topLeft: Radius
                                                                  .circular(8),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .center),
                                                                ),
                                                              ),
                                                              imageUrl: products[
                                                                      index]
                                                                  .image!
                                                                  .getBannerUrl(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                'asserts/images/ayikie_logo.png',
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: (MediaQuery.of(
                                                                            context)
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
                                                                  products[
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                                Text(products[
                                                                        index]
                                                                    .introduction),
                                                                Text(
                                                                  '\$${products[index].price}',
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
