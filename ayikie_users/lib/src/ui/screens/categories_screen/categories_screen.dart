import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/Item.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/sub_categories_screen/sub_product_screen.dart';
import 'package:ayikie_users/src/ui/screens/sub_categories_screen/sub_service_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _isLoading = true;
  int currentIndex = 1;
  List<Item> productCategories = [];
  List<Item> serviceCategories = [];



  @override
  void initState() {
    super.initState();
    _getServiceCategories();
  }

  void _getServiceCategories({bool isRefresh = false}) async {

    if(isRefresh){
      setState(() {
        currentIndex++;
      });
    }

    await ApiCalls.getAllServiceCategory(page: currentIndex).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Item category = Item.fromJson(item);
          serviceCategories.add(category);
        }
        _getProductCategories();
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void _getProductCategories() async {
    await ApiCalls.getAllProductCategory().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Item category = Item.fromJson(item);
          productCategories.add(category);
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
              'Categories',
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 20,bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0),
                                itemBuilder: (ctx, index) {
                                  return CategoryService(index: index,serviceCategories: serviceCategories);
                                },
                                itemCount: serviceCategories.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 20,bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0),
                                itemBuilder: (ctx, index) {
                                  return CategoryProduct(index: index,productCategories: productCategories);
                                },
                                itemCount: productCategories.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CategoryService extends StatelessWidget {

  final int index;
  final List<Item> serviceCategories;

  const CategoryService({
    Key? key,
    required this.index,
    required this.serviceCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SubSeriveScreen(categoryId: serviceCategories[index].id);
          }),
        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryButtonColor,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              height: 100,
              child:CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.center),
                  ),
                ),
                imageUrl: serviceCategories[index].image!.getBannerUrl(),
                errorWidget: (context, url, error) => Image.asset(
                  'asserts/images/ayikie_logo.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Spacer(),
            Text(
            serviceCategories[index].name,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class CategoryProduct extends StatelessWidget {

  final int index;
  final List<Item> productCategories;

  const CategoryProduct({
    Key? key,
    required this.index,
    required this.productCategories
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SubProductScreen(categoryId: productCategories[index].id);
          }),
        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryButtonColor,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              height: 100,
              child:CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.center),
                  ),
                ),
                imageUrl: productCategories[index].image!.getBannerUrl(),
                errorWidget: (context, url, error) => Image.asset(
                  'asserts/images/ayikie_logo.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Spacer(),
            Text(
              productCategories[index].name,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
