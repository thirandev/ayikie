import 'dart:io';
import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/order.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/image_source_dialog.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/common.dart';
import 'package:ayikie_users/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceOrderDetails extends StatefulWidget {
  final Order serviceOrder;

  ServiceOrderDetails({Key? key, required this.serviceOrder}) : super(key: key);

  @override
  _ServiceOrderDetailsState createState() => _ServiceOrderDetailsState();
}

class _ServiceOrderDetailsState extends State<ServiceOrderDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;
  double rate = 1.0;
  late File _reviewPhoto;
  bool isUploaded = false;

  @override
  void initState() {
    super.initState();
    _currentStep = 2;
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  onTapCancelOrder() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            'My Service Orders',
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
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stepper(
                          type: stepperType,
                          physics: ScrollPhysics(),
                          currentStep: _currentStep,
                          // onStepTapped: (step) => tapped(step),
                          controlsBuilder: (BuildContext context,
                              {VoidCallback? onStepContinue,
                              VoidCallback? onStepCancel}) {
                            return _currentStep != 3
                                ? Container(
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: _currentStep == 2
                                          ? AppColors.primaryButtonColor
                                          : AppColors.redButtonColor,
                                    ),
                                    child: FlatButton(
                                      onPressed: onCommonButtonPress,
                                      child: Text(
                                          _currentStep == 0
                                              ? 'Delete Order'
                                              : _currentStep == 1
                                                  ? 'Cancel Order'
                                                  : 'Submit',
                                          style: TextStyle(
                                            color: AppColors.white,
                                          )),
                                      //  textColor: _currentStep == 0? AppColors.redButtonColor: AppColors.primaryButtonColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ))
                                : Container();
                          },
                          steps: [
//This is the first stepper *********************************************************
                            Step(
                              // title: new Image.asset(
                              //   'asserts/images/pending_approval.png',
                              //   height: 65,
                              // ),
                              title: Row(
                                children: [
                                  Text(
                                    'Order Pending',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  new Image.asset(
                                    'asserts/images/pending_approval.png',
                                    height: 65,
                                  ),
                                ],
                              ),
                              content: OrderDetails(
                                  serviceOrder: widget.serviceOrder),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            //This is the second stepper *********************************************************
                            Step(
                              // title: new Image.asset(
                              //   'asserts/images/order_accepted.png',
                              //   height: 65,
                              // ),
                              title: Row(
                                children: [
                                  new Image.asset(
                                    'asserts/images/order_accepted.png',
                                    height: 65,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Order Accepted',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              content: OrderDetails(
                                  serviceOrder: widget.serviceOrder),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            //This is the third stepper *********************************************************
                            Step(
                              // title: new Image.asset(
                              //   'asserts/images/order_ongoing.png',
                              //   height: 65,
                              // ),
                              title: Row(
                                children: [
                                  Text(
                                    'Order Ongoing',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  new Image.asset(
                                    'asserts/images/order_ongoing.png',
                                    height: 65,
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  OrderDetails(
                                      serviceOrder: widget.serviceOrder),
                                  Text(
                                    'Upload Photos',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  isUploaded?
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.textFieldBackground,
                                      ),
                                      width: double.infinity,
                                      height: 75,
                                      child:  Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons.check_circle,
                                            color: Colors.green,
                                          ),
                                          Text('Uploaded Successfully'),
                                        ],
                                      )
                                  ):
                                  GestureDetector(
                                    onTap:_updatePicture,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.textFieldBackground,
                                      ),
                                      width: double.infinity,
                                      height: 75,
                                      child:  Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt_outlined),
                                          Text('Photos'),
                                        ],
                                      )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Review',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    child: TextField(
                                      maxLines: 9,
                                      controller: _messageController,
                                      decoration: InputDecoration(
                                          hintText: "Enter a message",
                                          fillColor:
                                              AppColors.textFieldBackground,
                                          filled: true,
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                            left: 15,
                                            top: 30,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Rating',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: RatingBar.builder(
                                      wrapAlignment: WrapAlignment.start,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemSize: 25,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                        setState(() {
                                          rate = rating;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            //this is the fourth step**********************************************
                            Step(
                              // title: new Image.asset(
                              //   'asserts/images/order_ongoing.png',
                              //   height: 65,
                              // ),
                              title: Row(
                                children: [
                                  new Image.asset(
                                    'asserts/images/order_completed.png',
                                    height: 65,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Order Completed',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  OrderDetails(
                                      serviceOrder: widget.serviceOrder),
                                  Row(
                                    children: [
                                      Text(
                                        'Order Status',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        Common.getStatus(
                                            status: widget.serviceOrder.status),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Photos',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'asserts/images/black_guitar.jpg',
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Review',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at ',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Rating',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: RatingBar.builder(
                                      wrapAlignment: WrapAlignment.start,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemSize: 25,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 3
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _updatePicture() {
    ImageSourceDialog.show(context, _selectPicture);
  }

  Future _selectPicture(int mode) async {
    if (mode == 1) {
      try {
        var image = await ImagePicker().getImage(
            source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
        if (image != null) {
          _reviewPhoto = File(image.path);
          setState(() {
            isUploaded = true;
          });
        }
      } on PlatformException catch (e) {
        Alerts.showMessage(context,
            "Access to the camera has been denied, please enable it to continue.");
      } catch (e) {
        Alerts.showMessage(context, e.toString());
      }
    } else {
      try {
        var image = await ImagePicker().getImage(
            source: ImageSource.gallery, maxWidth: 400, maxHeight: 400);
        if (image != null) {
          _reviewPhoto = File(image.path);
          setState(() {
            isUploaded = true;
          });
          print('here');
        }
      } on PlatformException catch (e) {
        Alerts.showMessage(context,
            "Access to the gallery has been denied, please enable it to continue.");
      } catch (e) {
        Alerts.showMessage(context, e.toString());
      }
    }
  }

  void onCommonButtonPress() {
    // _currentStep < 3 ? setState(() => _currentStep += 1) : null;
    switch(_currentStep){
      case 0:
        deleteOrder();
        break;
      case 1:
        cancelOrder();
        break;
      case 2:
        reviewOrder();
    }
  }

  void deleteOrder() async{
    setState(() {
      _isLoading = true;
    });

    ApiCalls.deleteServiceOrder(widget.serviceOrder.orderId)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Order Deleted sucessfully.",
            title: "Success!",onCloseCallback: ()=>    Navigator.pushNamedAndRemoveUntil(
                context, '/UserScreen', (route) => false)
        );
      } else {
        Alerts.showMessageForResponse(context, response);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void cancelOrder() async{
    setState(() {
      _isLoading = true;
    });
    ApiCalls.cancelServiceOrder(widget.serviceOrder.orderId)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Order Cancelled sucessfully.",
            title: "Success!", onCloseCallback:()=>    Navigator.pushNamedAndRemoveUntil(
                context, '/UserScreen', (route) => false));
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void reviewOrder() async{

    String message = _messageController.text.trim();

    if (!Validations.validateString(message)) {
      Alerts.showMessage(context, "Enter your review");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    ApiCalls.reviewServiceOrder(serviceId: 1,comment: message,rate: rate,picture:_reviewPhoto)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Order Reviewed sucessfully.",
            title: "Success!", onCloseCallback: ()=>    Navigator.pushNamedAndRemoveUntil(
                context, '/UserScreen', (route) => false)
            );
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

}

class OrderDetails extends StatelessWidget {
  final Order serviceOrder;

  OrderDetails({Key? key, required this.serviceOrder}) : super(key: key);

  TextEditingController _priceController = TextEditingController();
  TextEditingController _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              serviceOrder.service.name,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            Spacer(),
            new IconButton(
              icon: new Icon(
                Icons.call_outlined,
                color: AppColors.black,
              ),
              onPressed: () {
                _makePhoneCall(serviceOrder.service.phoneNumber);
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
          'Order Requirenmets',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          serviceOrder.note,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Order Price',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
            Spacer(),
            Flexible(
                child: CustomFormField(
              controller: _priceController,
              isEnabled: true,
              height: 35,
              hintText: '\$ ${serviceOrder.price}',
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
            Spacer(),
            Flexible(
                child: CustomFormField(
              controller: _durationController,
              height: 35,
              hintText: '${serviceOrder.duration} day',
              isEnabled: true,
            )),
          ],
        ),
        SizedBox(
          height: 20,
        )
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
