import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/buyerRequest.dart';
import 'package:ayikie_users/src/models/offer.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/post_request_screen/post_request_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MyOffersScreen extends StatefulWidget {
  final int requestId;
  const MyOffersScreen({Key? key,required this.requestId}) : super(key: key);

  @override
  _MyOffersScreenState createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {

  late BuyerRequest buyerRequest;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getRequest();
  }

  void _getRequest() async {
    await ApiCalls.getBuyerRequest(widget.requestId.toString()).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        buyerRequest = BuyerRequest.fromJson(data);
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
          'My Offers',
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
            :SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: buyerRequest.offers.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CommentWidget(offer: buyerRequest.offers[index],
                            onCancelOffer: (){cancelOrder(buyerRequest.offers[index].id);},
                            onAcceptOffer: (){acceptOffer(buyerRequest.offers[index].id);},
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void cancelOrder(int requestId) async{
    setState(() {
      _isLoading = true;
    });
    ApiCalls.cancelBuyerRequest(requestId.toString())
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Offer Cancelled successfully.",
            title: "Success!", onCloseCallback:()=> Navigator.pop(context));
        _getRequest();
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void acceptOffer(int requestId) async{
    setState(() {
      _isLoading = true;
    });
    ApiCalls.acceptBuyerRequest(requestId.toString())
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Offer Accepted successfully.",
            title: "Success!", onCloseCallback:()=> {
          Navigator.pop(context),
              Navigator.pop(context),
            });
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }

    });
  }

}

class CommentWidget extends StatelessWidget {
  Offer offer;
  VoidCallback onAcceptOffer;
  VoidCallback onCancelOffer;
  CommentWidget({
    Key? key,
    required this.offer,
    required this.onAcceptOffer,
    required this.onCancelOffer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.textFieldBackground),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                alignment: AlignmentDirectional.center),
                          ),
                        ),
                        imageUrl: offer.user!.imgUrl.imageName,
                        errorWidget: (context, url, error) => Image.asset(
                          'asserts/images/ayikie_logo.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    offer.user!.name,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: onCancelOffer,
                    child: Icon(
                      Icons.close,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(offer.description)),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Order Amount :',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                  Text(
                    '\$${offer.price}',
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                  Text(
                    '${offer.duration} days',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  new IconButton(
                    icon: new Icon(
                      Icons.call_outlined,
                      color: AppColors.black,
                    ),
                    onPressed: () {
                      _makePhoneCall(offer.user!.phone);
                    },
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.chat_bubble_outline_sharp,
                      color: AppColors.black,
                    ),
                    onPressed: () {},
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: onAcceptOffer,
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryButtonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Accept Offer',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

}

