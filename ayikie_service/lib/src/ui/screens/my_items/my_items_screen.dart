import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/product.dart';
import 'package:ayikie_service/src/models/service.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyItemsScreen extends StatefulWidget {
  const MyItemsScreen({Key? key}) : super(key: key);

  @override
  _MyItemsScreenState createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State<MyItemsScreen> {
  bool _isLoading = true;

  List<Service> popularServices = [];
  List<Product> popularProducts = [];

  @override
  void initState() {
    super.initState();
   // _getServices();
  }

  // void _getServices() async {
  //   await ApiCalls.getPopularServices().then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     if (response.isSuccess) {
  //       var data = response.jsonBody;
  //       for (var item in data) {
  //         Service popular = Service.fromJson(item);
  //         popularServices.add(popular);
  //       }
  //     } else {
  //       Alerts.showMessage(context, "Something went wrong. Please try again.",
  //           title: "Oops!");
  //     }
  //     _getProducts();
  //   });
  // }

  // void _getProducts() async {
  //   await ApiCalls.getPopularProducts().then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     if (response.isSuccess) {
  //       var data = response.jsonBody;
  //       for (var item in data) {
  //         Product popular = Product.fromJson(item);
  //         popularProducts.add(popular);
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.black),
            backgroundColor: AppColors.white,
            elevation: 0,
            title: Text(
              'My Items',
              style: TextStyle(
                color: Colors.black,
              ),
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
            bottom: TabBar(
                labelColor: AppColors.black,
                indicatorColor: AppColors.primaryButtonColor,
                indicatorWeight: 2.5,
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                tabs: [
                  Tab(
                    text: ('Service'),
                  ),
                  Tab(
                    text: ('Product'),
                  ),
                ]),
          ),
          endDrawer: DrawerScreen(),
          body: _isLoading
              ? Center(
                  child: ProgressView(),
                )
              : TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: popularServices.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PopularServiceWidget(
                                    popularServices: popularServices,
                                    index: index)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: popularProducts.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PopularProductWidget(
                                    popularProducts: popularProducts,
                                    index: index)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class PopularProductWidget extends StatelessWidget {
  final List<Product> popularProducts;
  final int index;

  PopularProductWidget(
      {Key? key, required this.popularProducts, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: AppColors.textFieldBackground,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width - 40) / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.center),
                    ),
                  ),
                  imageUrl: popularProducts[index].image!.getBannerUrl(),
                  errorWidget: (context, url, error) => Image.asset(
                    'asserts/images/ayikie_logo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      popularProducts[index].name,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      popularProducts[index].introduction,
                    ),
                    Text(
                      '\$${popularProducts[index].price}',
                      style: TextStyle(fontWeight: FontWeight.w900),
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

class PopularServiceWidget extends StatelessWidget {
  final List<Service> popularServices;
  final int index;

  PopularServiceWidget(
      {Key? key, required this.popularServices, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: AppColors.textFieldBackground,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width - 40) / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.center),
                    ),
                  ),
                  imageUrl: popularServices[index].image!.getBannerUrl(),
                  errorWidget: (context, url, error) => Image.asset(
                    'asserts/images/ayikie_logo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      popularServices[index].name,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(popularServices[index].introduction),
                    Text(
                      '\$${popularServices[index].price}',
                      style: TextStyle(fontWeight: FontWeight.w900),
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
