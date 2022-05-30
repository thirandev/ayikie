import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/meta.dart';
import 'package:ayikie_users/src/models/product.dart';
import 'package:ayikie_users/src/models/service.dart';
import 'package:ayikie_users/src/ui/screens/Item/product_screen.dart';
import 'package:ayikie_users/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecommandedScreen extends StatefulWidget {
  const RecommandedScreen({Key? key}) : super(key: key);

  @override
  _RecommandedScreenState createState() => _RecommandedScreenState();
}

class _RecommandedScreenState extends State<RecommandedScreen> {
  bool _isLoading = true;
  int currentIndex = 1;
  int currentIndexProduct = 1;

  late ScrollController _controllerService;
  late ScrollController _controllerProduct;

  bool isLastPage = false;
  bool isLastPageProduct = false;
  bool isFirstLoad = true;

  List<Service> recommandedServices = [];
  List<Product> recommandedProducts = [];

  @override
  void initState() {
    super.initState();
    _getServices();
    _controllerService = new ScrollController()..addListener(loadMoreService);
    _controllerProduct = new ScrollController()..addListener(loadMoreProduct);
  }

  void loadMoreService() {
    if (_controllerService.position.extentAfter < 250 &&
        !isLastPage &&
        !_isLoading) {
      setState(() {
        currentIndex++;
        _isLoading = true;
      });
      _getServices(loadData: true);
    }
  }

  void loadMoreProduct() {
    if (_controllerProduct.position.extentAfter < 250 &&
        !isLastPageProduct &&
        !_isLoading) {
      setState(() {
        currentIndexProduct++;
        _isLoading = true;
      });
      _getProducts();
    }
  }

  void _getServices({bool? loadData}) async {
    await ApiCalls.getRecommendedServices(page: currentIndex).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var meta = response.metaBody;
        Meta _meta = Meta.fromJson(meta);
        isLastPage = _meta.lastPage == currentIndex;
        var data = response.jsonBody;
        for (var item in data) {
          Service recommand = Service.fromJson(item);
          recommandedServices.add(recommand);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      if (loadData != null && loadData) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      _getProducts();
    });
  }

  void _getProducts() async {
    await ApiCalls.getRecommendedProducts(page: currentIndexProduct).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var meta = response.metaBody;
        Meta metaProduct = Meta.fromJson(meta);
        isLastPageProduct = metaProduct.lastPage == currentIndexProduct;
        var data = response.jsonBody;
        for (var item in data) {
          Product recommand = Product.fromJson(item);
          recommandedProducts.add(recommand);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
        isFirstLoad = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerProduct.dispose();
    _controllerService.dispose();
  }

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
              'Recommanded ',
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
          body: _isLoading && isFirstLoad
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
                            controller: _controllerService,
                            scrollDirection: Axis.vertical,
                            itemCount: recommandedServices.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PopularServiceWidget(
                                    recommandedServices:
                                        recommandedServices[index])),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            controller: _controllerProduct,
                            itemCount: recommandedProducts.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PopularProductWidget(
                                    recommandedProduct:
                                        recommandedProducts[index])),
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
  final Product recommandedProduct;

  const PopularProductWidget({Key? key, required this.recommandedProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ProductScreen(productId: recommandedProduct.id);
          }),
        );
      },
      child: Padding(
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
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            alignment: AlignmentDirectional.center),
                      ),
                    ),
                    imageUrl: recommandedProduct.image!.getBannerUrl(),
                    errorWidget: (context, url, error) => Image.asset(
                      'asserts/images/ayikie_logo.png',
                      fit: BoxFit.cover,
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
                        recommandedProduct.introduction,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                          'I offer best prise plan and the highly productive service for your side'),
                      Text(
                        '\$${recommandedProduct.price}',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
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

class PopularServiceWidget extends StatelessWidget {
  final Service recommandedServices;

  const PopularServiceWidget({Key? key, required this.recommandedServices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ServiceScreen(serviceId: recommandedServices.id);
          }),
        );
      },
      child: Padding(
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
                        
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            alignment: AlignmentDirectional.center),
                      ),
                    ),
                    imageUrl: recommandedServices.image!.getBannerUrl(),
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
                        recommandedServices.name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(recommandedServices.introduction),
                      Text(
                        '\$${recommandedServices.price} / hr',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
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
