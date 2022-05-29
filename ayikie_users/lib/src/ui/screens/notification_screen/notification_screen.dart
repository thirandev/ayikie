import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/meta.dart';
import 'package:ayikie_users/src/models/notification.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isLoading = true;
  List<Notifications> notifications = [];

  int currentIndex = 1;
  bool isLastPage = false;
  bool isFirstLoad = true;

  late ScrollController _controllerService;

  @override
  void initState() {
    super.initState();
    _getNotification();
    _controllerService = new ScrollController()..addListener(loadMoreService);
  }

  void loadMoreService() {
    if (_controllerService.position.extentAfter < 250 &&
        !isLastPage &&
        !_isLoading) {
      setState(() {
        currentIndex++;
        _isLoading = true;
      });
      _getNotification(loadData: true);
    }
  }


  void _getNotification({bool? loadData}) async {
    await ApiCalls.getNotification(page: currentIndex).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var meta = response.metaBody;
        Meta _meta = Meta.fromJson(meta);
        isLastPage = _meta.lastPage == currentIndex;
        var data = response.jsonBody;
        for (var item in data) {
          Notifications notify = Notifications.fromJson(item);
          notifications.add(notify);
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
      _readAll();
    });
  }

  void _readAll() async {
    await ApiCalls.readAllNotification().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
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
    _controllerService.dispose();
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
          'Notification',
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
            builder: (context) =>
                GestureDetector(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 26,
                      height: 26,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(180 / 360),
                        child: Image.asset(
                          'asserts/icons/menu.png',
                          scale: 10,
                        ),
                      ),
                      // Image(
                      //   image: Images.getImage('assets/icons/menu.png'),
                      // ),
                    ),
                  ),
                ),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
      body: Builder(
        builder: (context) =>
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: _isLoading
                  ? Center(
                child: ProgressView(),
              )
                  : notifications.isEmpty
                  ? Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asserts/images/empty.png',
                        scale: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('No Notifications Here',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20))
                    ],
                  ),
                ),
              )
                  : Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: _controllerService,
                    scrollDirection: Axis.vertical,
                    itemCount: notifications.length,
                    itemBuilder: (BuildContext context, int index) =>
                        NotificationTileWidget(
                            notifications: notifications[index])),
              ),
            ),
      ),
    );
  }
}

class NotificationTileWidget extends StatelessWidget {
  final Notifications notifications;
  const NotificationTileWidget({
    Key? key,
    required this.notifications
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.0,
                backgroundColor: AppColors.redColor,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 7.5, top: 7.5),
                child: Text(
                  notifications.title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 7.5),
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  notifications.message,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 10),
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  Common.dateFormator(ios8601: notifications.createdAt),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.divider,
          ),
        ],
      ),
    );
  }
}
