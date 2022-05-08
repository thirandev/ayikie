import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/comment.dart';
import 'package:ayikie_users/src/models/service.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/validations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceScreen extends StatefulWidget {
  final int serviceId;

  const ServiceScreen({Key? key, required this.serviceId}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  bool _isLoading = true;
  late Service service;

  @override
  void initState() {
    super.initState();
    getServiceData();
  }

  void getServiceData() async {
    await ApiCalls.getService(serviceId: widget.serviceId).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        service = Service.fromJson(response.jsonBody);
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
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _messageController.dispose();
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
            'Service',
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
        body: _isLoading
            ? Center(
                child: ProgressView(),
              )
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                          height: 175,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      alignment: AlignmentDirectional.center),
                                ),
                              ),
                              imageUrl: service.image!.getBannerUrl(),
                              errorWidget: (context, url, error) => Image.asset(
                                'asserts/images/ayikie_logo.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              service.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                            Spacer(),
                            new IconButton(
                              icon: new Icon(
                                Icons.call_outlined,
                                color: AppColors.black,
                              ),
                              onPressed: () {
                                _makePhoneCall(service.phoneNumber);
                              },
                            ),
                            new IconButton(
                              icon: new Icon(
                                Icons.chat_bubble_outline_sharp,
                                color: AppColors.black,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          service.introduction,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          service.description ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '\$${service.price} / h',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                        Row(
                          children: [
                            Text(
                              'Order Price',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                            Spacer(),
                            Flexible(
                                child: CustomFormField(
                              controller: _priceController,
                              inputType: TextInputType.number,
                              height: 35,
                              hintText: '\$25',
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Order Duration',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                            Spacer(),
                            Flexible(
                                child: CustomFormField(
                              controller: _durationController,
                              inputType: TextInputType.number,
                              height: 35,
                              hintText: '1 day',
                            )),
                          ],
                        ),
                        Text(
                          'Message',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomFormField(controller: _messageController),
                        SizedBox(
                          height: 30,
                        ),
                        PrimaryButton(
                          text: 'Request Offer',
                          clickCallback: requestOffer,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Comments',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: service.comment!.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                                  children: [
                                    CommentWidget(
                                      comment: service.comment![index],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
              )));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void requestOffer() async {
    String price = _priceController.text.trim();
    String duration = _durationController.text.trim();
    String message = _messageController.text.trim();

    if (!Validations.validateString(price)) {
      Alerts.showMessage(context, "Enter order price");
      return;
    }

    if (!Validations.validateString(duration)) {
      Alerts.showMessage(context, "Enter order duration");
      return;
    }

    if (!Validations.validateString(message)) {
      Alerts.showMessage(context, "Enter your message");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    ApiCalls.createServiceOrder(
            message: message,
            duration: int.parse(duration),
            serviceId: service.id,
            price: double.parse(price),
            location: service.location)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Requested service sucessfully.",
            title: "Success!", onCloseCallback: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/UserScreen', (route) => false);
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
  Comment comment;

  CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            alignment: AlignmentDirectional.center),
                      ),
                    ),
                    imageUrl: comment.user.imgUrl.imageName,
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
                comment.user.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(alignment: Alignment.centerLeft, child: Text(comment.comment)),
          SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RatingBar.builder(
              ignoreGestures: true,
              wrapAlignment: WrapAlignment.start,
              initialRating: comment.rate.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              itemSize: 25,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
          ),
        ],
      ),
    );
  }
}
