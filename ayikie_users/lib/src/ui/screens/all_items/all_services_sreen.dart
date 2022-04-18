import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/service.dart';
import 'package:ayikie_users/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllServicescreen extends StatefulWidget {
  final int subCategoryId;

  AllServicescreen({Key? key, required this.subCategoryId}) : super(key: key);

  @override
  _AllServicescreenState createState() => _AllServicescreenState();
}

class _AllServicescreenState extends State<AllServicescreen> {
  bool _isLoading = true;
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    _getSubServices();
  }

  void _getSubServices() async {
    await ApiCalls.getServicesInSubCategory(categoryId: widget.subCategoryId)
        .then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        for (var item in data) {
          Service subService = Service.fromJson(item);
          services.add(subService);
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
          'All Services',
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
                          itemCount: services.length,
                          itemBuilder: (BuildContext context, int index) =>
                              SubCategoryWidget(index: index,services: services)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final List<Service> services;
  final int index;
  SubCategoryWidget({
    Key? key,
    required this.index,
    required this.services
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Alerts.showGuestMessage(context);
        return;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) {
        //     return ServiceScreen(serviceId: services[index].id);
        //   }),
        // );
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
                      imageUrl: services[index].image!.getBannerUrl(),
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
                        services[index].name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        services[index].introduction),
                      Text(
                        '\$${services[index].price} / hr',
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
