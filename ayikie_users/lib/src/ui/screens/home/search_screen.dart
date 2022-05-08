import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/Item.dart';
import 'package:ayikie_users/src/models/search.dart';
import 'package:ayikie_users/src/models/service.dart';
import 'package:ayikie_users/src/ui/screens/Item/product_screen.dart';
import 'package:ayikie_users/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_users/src/ui/screens/all_items/all_products_screen.dart';

import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';

import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isLoading = true;
  TextEditingController controller = new TextEditingController();
  List<Search> searches = [];
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _search("");
  }

  void _search(String keyword) async {
    setState(() {
      _isLoading = true;
    });
    await ApiCalls.getSearchResults(keyword: keyword).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        searches.clear();
        for (var item in data) {
          Search result = Search.fromJson(item);
          searches.add(result);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Search again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
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
          'Search',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primaryButtonColor)),
                  child: ListTile(
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (key) {
                          _search(key);
                        },
                      ),
                      trailing: Icon(
                        Icons.search,
                        color: AppColors.primaryButtonColor,
                      )),
                ),
                SizedBox(height: 10),
                _isLoading
                    ? Center(
                        child: ProgressView(),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: searches.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SubCategoryWidget(
                              search: searches[index],
                            )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final Search search;

  SubCategoryWidget({Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return search.type == "product"
                ? ProductScreen(productId: search.id)
                : ServiceScreen(serviceId: search.id);
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
                    imageUrl: search.image!.getBannerUrl(),
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
                        search.name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(search.introduction),
                      Text(
                        '\$${search.price}',
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
