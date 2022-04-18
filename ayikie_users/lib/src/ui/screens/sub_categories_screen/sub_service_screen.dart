import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/Item.dart';
import 'package:ayikie_users/src/ui/screens/all_items/all_services_sreen.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SubSeriveScreen extends StatefulWidget {
  final int categoryId;

  const SubSeriveScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  _SubSeriveScreenState createState() => _SubSeriveScreenState();
}

class _SubSeriveScreenState extends State<SubSeriveScreen> {
  bool _isLoading = true;
  List<Item> subServices = [];

  @override
  void initState() {
    super.initState();
    print("Power" + widget.categoryId.toString());
    _getSubServices();
  }

  void _getSubServices() async {
    await ApiCalls.getAllSubServiceCategory(categoryId: widget.categoryId)
        .then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Item subService  = Item.fromJson(item);
          print(subService.image!.getBannerUrl());
          subServices.add(subService);
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Sub Service',
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
                        Alerts.showGuestMessage(context);
                        return;
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) {
                        //     return NotificationScreen();
                        //   }),
                        // );
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
      body: _isLoading
          ? Center(
              child: ProgressView(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: subServices.length,
                          itemBuilder: (BuildContext context, int index) =>
                              SubCategoryWidget(subServices: subServices,index: index,)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final List<Item> subServices;
  final int index;
  const SubCategoryWidget({
    Key? key,
    required this.subServices,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return AllServicescreen(subCategoryId: subServices[index].id);
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
                      imageUrl: subServices[index].image!.getBannerUrl(),
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
                      subServices[index].name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(subServices[index].description??""),
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
