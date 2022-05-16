import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/order.dart';
import 'package:ayikie_service/src/models/user.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceOrderDetails extends StatefulWidget {
  final Order serviceOrder;

  const ServiceOrderDetails({Key? key, required this.serviceOrder})
      : super(key: key);

  @override
  _ServiceOrderDetailsState createState() => _ServiceOrderDetailsState();
}

class _ServiceOrderDetailsState extends State<ServiceOrderDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextEditingController _priceController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  bool _isLoading = true;
  late User customer;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  onTapCancelOrder() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  @override
  void initState() {
    super.initState();
    if(widget.serviceOrder.status == 3){
      _currentStep = 2;
    }else{
      _currentStep = widget.serviceOrder.status;
    }
    _priceController.text = widget.serviceOrder.price.toString();
    _durationController.text = widget.serviceOrder.duration.toString();
    _getOrderCustomer();
  }

  void _getOrderCustomer() async {
    await ApiCalls.getServiceOrder(widget.serviceOrder.orderId).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        customer = User.fromJson(data["customer"]);
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
    // TODO: implement dispose
    super.dispose();
    _priceController.dispose();
    _durationController.dispose();
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
                            return _currentStep != 2
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
                                              ? 'Cancel Offer'
                                              : 'Delete Order',
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
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        customer.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.call_outlined,
                                          color: AppColors.black,
                                        ),
                                        onPressed: () {
                                          _makePhoneCall(customer.phone);
                                        },
                                      ),
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.chat_bubble_outline_sharp,
                                          color: AppColors.black,
                                        ),
                                        onPressed: () {
                                          onTapCancelOrder();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Requirements',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.serviceOrder.note,
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
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Flexible(
                                          child: CustomFormField(
                                        isEnabled: true,
                                        controller: _priceController,
                                        height: 35,
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Flexible(
                                          child: CustomFormField(
                                        isEnabled: true,
                                        controller: _durationController,
                                        height: 35,
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  PrimaryButton(
                                      text: 'Accept Offer',
                                      fontSize: 14,
                                      clickCallback: acceptOrder),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
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
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        customer.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.call_outlined,
                                          color: AppColors.black,
                                        ),
                                        onPressed: () {
                                          _makePhoneCall(customer.phone);
                                        },
                                      ),
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.chat_bubble_outline_sharp,
                                          color: AppColors.black,
                                        ),
                                        onPressed: () {
                                          onTapCancelOrder();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Requirements',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.serviceOrder.note,
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
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Flexible(
                                          child: CustomFormField(
                                            isEnabled: true,
                                            controller: _priceController,
                                        height: 35,
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Flexible(
                                          child: CustomFormField(
                                            isEnabled: true,
                                        controller: _durationController,
                                        height: 35,
                                        hintText: '1 day',
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  PrimaryButton(
                                      text: 'Deliver Order',
                                      fontSize: 14,
                                      clickCallback: deliverOrder),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
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
                                  Row(
                                    children: [
                                      Text(
                                        customer.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.call_outlined,
                                          color: AppColors.black,
                                        ),
                                        onPressed: () {
                                          _makePhoneCall(customer.phone);
                                        },
                                      ),
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.chat_bubble_outline_sharp,
                                          color: AppColors.black,
                                        ),
                                        onPressed: () {
                                          onTapCancelOrder();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Order Requirements',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.serviceOrder.note,
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
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Flexible(
                                          child: CustomFormField(
                                            isEnabled: true,
                                        controller: _priceController,
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Flexible(
                                          child: CustomFormField(
                                        controller: _durationController,
                                            isEnabled: true,
                                            height: 35,
                                        hintText: '1 day',
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                        'Order Completed',
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
                                    widget.serviceOrder.note
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

  void onCommonButtonPress(){
    _currentStep < 3
        ? setState(() => _currentStep += 1)
        : null;

    // TODO: Uncomment below and delete above
    // switch(_currentStep){
    //   case 0:
    //     cancelOrder();
    //     break;
    //   case 1:
    //     deleteOrder();
    //     break;
    // }
  }

  void acceptOrder() async {
    setState(() {
      _isLoading = true;
    });
    ApiCalls.acceptServiceOrder(widget.serviceOrder.orderId)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Order Cancelled successfully.",
            title: "Success!",
            onCloseCallback: () => Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false));
      } else {
        Alerts.showMessageForResponse(context, response);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void deliverOrder() async {
    setState(() {
      _isLoading = true;
    });
    ApiCalls.deliverServiceOrder(widget.serviceOrder.orderId)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Order Delivered successfully.",
            title: "Success!",
            onCloseCallback: () => Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false));
      } else {
        Alerts.showMessageForResponse(context, response);
      }
      setState(() {
        _isLoading = false;
      });
    });
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
        Alerts.showMessage(context, "Order Deleted successfully.",
            title: "Success!",onCloseCallback: ()=>    Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false)
        );
      } else {
        Alerts.showMessageForResponse(context, response);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void cancelOrder() async {
    setState(() {
      _isLoading = true;
    });
    ApiCalls.cancelServiceOrder(widget.serviceOrder.orderId)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Order Cancelled successfully.",
            title: "Success!",
            onCloseCallback: () => Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false));
      } else {
        Alerts.showMessageForResponse(context, response);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

}
