import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/Item.dart';
import 'package:ayikie_users/src/models/meta.dart';
import 'package:ayikie_users/src/ui/screens/all_items/all_products_screen.dart';

import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';

import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SubProductScreen extends StatefulWidget {
  final int categoryId;

  const SubProductScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _SubProductScreenState createState() => _SubProductScreenState();
}

class _SubProductScreenState extends State<SubProductScreen> {
  bool _isLoading = true;

  List<Item> subProducts = [];
  int currentIndex = 1;
  late ScrollController _controller;
  bool isLastPage = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController()..addListener(loadMore);
    _getProductsInCategory();
  }

  void loadMore() {
    if (_controller.position.extentAfter < 250 && !isLastPage && !_isLoading) {
      setState(() {
        currentIndex++;
        _isLoading = true;
      });
      _getProductsInCategory();
    }
  }

  void _getProductsInCategory() async {
    await ApiCalls.getAllSubProductCategory(
            categoryId: widget.categoryId, page: currentIndex)
        .then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var meta = response.metaBody;
        Meta _meta = Meta.fromJson(meta);
        isLastPage = _meta.lastPage == currentIndex;
        var data = response.jsonBody;
        for (var item in data) {
          Item subProduct = Item.fromJson(item);
          subProducts.add(subProduct);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Sub Products',
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
      ),
      endDrawer: DrawerScreen(),
      body: _isLoading && isFirstLoad
          ? Center(
              child: ProgressView(),
            )
          : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  itemCount: subProducts.length,
                  itemBuilder: (BuildContext context, int index) =>
                      SubCategoryWidget(
                        subProduct: subProducts[index],
                      )),
            ),
          ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final Item subProduct;

  const SubCategoryWidget({Key? key, required this.subProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return AllProductcreen(subCategoryId: subProduct.id);
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
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.center),
                      ),
                    ),
                    imageUrl: subProduct.image!.getBannerUrl(),
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
                        subProduct.name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(subProduct.description ?? ""),
                      SizedBox(height: 5)
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
