import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/buyerRequest.dart';
import 'package:ayikie_users/src/models/meta.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/create_request.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/my_offers.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/common.dart';
import 'package:flutter/material.dart';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<PostRequestScreen> {
  bool _isLoading = true;
  int currentIndex = 1;
  int currentIndexProduct = 1;

  List<BuyerRequest> buyerRequests = [];

  late ScrollController _controller;
  bool isLastPage = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _getRequest();
    _controller = new ScrollController()..addListener(loadMore);
  }

  void loadMore() {
    if (_controller.position.extentAfter < 240 && !isLastPage && !_isLoading) {
      setState(() {
        currentIndex++;
        _isLoading = true;
      });
      _getRequest(loadData: true);
    }
  }

  void _getRequest({bool? loadData}) async {
    await ApiCalls.getAllBuyerRequest(page: currentIndex).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var meta = response.metaBody;
        Meta _meta = Meta.fromJson(meta);
        isLastPage = _meta.lastPage == currentIndex;
        var data = response.jsonBody;
        for (var item in data) {
          BuyerRequest buyer = BuyerRequest.fromJson(item);
          buyerRequests.add(buyer);
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
          'Post a Request',
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
                    SizedBox(width: 10),
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
        child: _isLoading
            ? Center(
                child: ProgressView(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 180,
                        child: ListView.builder(
                            controller: _controller,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: buyerRequests.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PostRequestTile(
                                    request: buyerRequests[index],
                                    deletePress: () {
                                      deleteRequest(buyerRequests[index].id);
                                    })),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                          text: 'Post a Request',
                          clickCallback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CreateRequestScreen();
                              }),
                            );
                          }),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void deleteRequest(int requestId) async {
    setState(() {
      _isLoading = true;
    });

    ApiCalls.deleteBuyerRequest(requestId).then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Request Deleted successfully.",
            title: "Success!", onCloseCallback: () => Navigator.pop(context));
        buyerRequests.clear();
        _getRequest();
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}

class PostRequestTile extends StatelessWidget {
  BuyerRequest request;
  final VoidCallback deletePress;

  PostRequestTile({Key? key, required this.request, required this.deletePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MyOffersScreen();
          }),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryButtonColor),
                color: AppColors.white),
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        Common.dateFormator(ios8601: request.createdAt),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      request.status == 1
                          ? Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red[400],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Active',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green[400],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Completed',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    request.title,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Amount :',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Text(
                        '\$${request.price}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Duration :',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Text(
                        '${request.duration} days',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Location :',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      Text(
                        request.location,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '${request.offers!.length} Offers Submitted',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      request.status == 1
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return CreateRequestScreen(
                                        buyerRequest: request);
                                  }),
                                );
                              },
                              child: Icon(Icons.edit))
                          : Container(),
                      SizedBox(
                        width: 10,
                      ),
                      request.status == 1
                          ? GestureDetector(
                              onTap: deletePress, child: Icon(Icons.delete))
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
