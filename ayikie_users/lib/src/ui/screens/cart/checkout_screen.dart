import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;
  const CheckoutScreen({Key? key,required this.totalPrice}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  int _locationDetails = 1;
  int _paymentsDetails = 0;
  bool _isLoading = false;

  StepperType stepperType = StepperType.vertical;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

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

  String getCurrentDate(){
    final now = new DateTime.now();
    String formatter = DateFormat.yMd().add_jm().format(now);
    return formatter;
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
            'Checkout',
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
                          onStepTapped: (step) => tapped(step),
                          controlsBuilder: (BuildContext context,
                              {VoidCallback? onStepContinue,
                              VoidCallback? onStepCancel}) {
                            return Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: _currentStep != 3
                                        ? AppColors.primaryButtonColor
                                        : AppColors.redButtonColor),
                                child: FlatButton(
                                  onPressed: () {
                                    _currentStep < 3
                                        ? setState(() => _currentStep += 1)
                                        : _currentStep == 3
                                            ? checkout()
                                            : null;
                                  },
                                  child: Text(
                                      _currentStep == 3
                                          ? 'Checkout'
                                          : 'Confirm',
                                      style: TextStyle(
                                        color: AppColors.white,
                                      )),
                                  //  textColor: _currentStep == 0? AppColors.redButtonColor: AppColors.primaryButtonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ));
                          },
                          steps: [
//This is the first stepper *********************************************************
                            Step(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Order Location',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Row(
                                  //   children: [
                                  //     Radio<int>(
                                  //       value: 1,
                                  //       groupValue: _locationDetails,
                                  //       onChanged: (value) {
                                  //         setState(() {
                                  //           _locationDetails = value!;
                                  //         });
                                  //       },
                                  //     ),
                                  //     Text(
                                  //       "Default Location",
                                  //       style: TextStyle(
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w500),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 1,
                                        groupValue: _locationDetails,
                                        onChanged: (value) {
                                          setState(() {
                                            _locationDetails = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Enter Location",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Radio<int>(
                                  //       value: 3,
                                  //       groupValue: _locationDetails,
                                  //       onChanged: (value) {
                                  //         setState(() {
                                  //           _locationDetails = value!;
                                  //         });
                                  //       },
                                  //     ),
                                  //     Text(
                                  //       "Select from Google Maps",
                                  //       style: TextStyle(
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w500),
                                  //     ),
                                  //   ],
                                  // ),
                                  _locationDetails == 1
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, top: 10),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Enter Address',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            CustomFormField(
                                              controller: _addressController,
                                              hintText: 'address',
                                              inputType: TextInputType.text,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            )
                                          ],
                                        )
                                      : _locationDetails == 2
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Your Default Address',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 20,
                                                  ),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '201/3, Araliya Mawatha, Thibbotugoda, Pokunuwita',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'get your current location',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Spacer(),
                                                    Icon(Icons.arrow_forward)
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '201/3, Araliya Mawatha, Thibbotugoda, Pokunuwita',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            )
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
                                  Icon(
                                    Icons.credit_card,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Payment Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 0,
                                        groupValue: _paymentsDetails,
                                        onChanged: (value) {
                                          setState(() {
                                            _paymentsDetails = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Cash on Delivery",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 1,
                                        groupValue: _paymentsDetails,
                                        onChanged: (value) {
                                          setState(() {
                                            _paymentsDetails = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Credit Card Payments",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  _paymentsDetails == 1
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                                height: 45,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: AppColors
                                                        .redButtonColor),
                                                child: FlatButton(
                                                  onPressed: () {},
                                                  child: Text('Add Your Card',
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                      )),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                )),
                                            SizedBox(
                                              height: 30,
                                            )
                                          ],
                                        )
                                      : Container()
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
                                  Icon(
                                    Icons.text_snippet_outlined,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Special Notes',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        'Add your Note here',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                    ],
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
                                    height: 30,
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
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.summarize_outlined,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Order Summery',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        'Items :',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Shopping Cart Items',
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
                                        'Order Date :',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        getCurrentDate(),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        _addressController.text,
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
                                        'Payment Method :',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        _paymentsDetails==0?'Cash on Delivery':'Credit Card',
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
                                        'Special Note :',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        _messageController.text,
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
                                        'Order Amount :',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                      Text(
                                        '\$${widget.totalPrice}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
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

  void checkout() async {
    String address = _addressController.text.trim();
    String message = _messageController.text.trim();

    if (!Validations.validateString(address)) {
      Alerts.showMessage(context, "Enter your address");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await ApiCalls.createProductOrder(location: address,method: _paymentsDetails,note: message).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Checkout is sucessfully.",
            title: "Success!",onCloseCallback: ()=>    Navigator.pushNamedAndRemoveUntil(
                context, '/UserScreen', (route) => false)
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

}
