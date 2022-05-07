import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/Item/service_screen.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductOrderDetails extends StatefulWidget {
  const ProductOrderDetails({Key? key}) : super(key: key);

  @override
  _ProductOrderDetailsState createState() => _ProductOrderDetailsState();
}

class _ProductOrderDetailsState extends State<ProductOrderDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextEditingController _priceController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
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
            'My Product Orders',
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
        body: SizedBox(
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
                                onPressed: () {
                                  _currentStep < 3
                                      ? setState(() => _currentStep += 1)
                                      : null;
                                },
                                child: Text(
                                    _currentStep == 0
                                        ? 'Cancel Order'
                                        : _currentStep == 1
                                            ? 'Delete Order'
                                            : 'Submit',
                                    style: TextStyle(
                                      color: AppColors.white,
                                    )),
                                //  textColor: _currentStep == 0? AppColors.redButtonColor: AppColors.primaryButtonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
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
                                  'Shopping Cart Items',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Spacer(),
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
                                  '2022/02/03 - 03.45',
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
                                  'Cash',
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
                                  'Colombo',
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
                                  'Special note :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  'Special note here',
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
                                  'Total Amount :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  '\$120',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       'Order Tracking no :',
                            //       style: TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.w900),
                            //     ),
                            //     Spacer(),
                            //     Text(
                            //       'EN5869523547856',
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                                text: 'Accept Order',
                                fontSize: 14,
                                clickCallback: () {}),
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
                                  'Shopping Cart Items',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Spacer(),
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
                                  '2022/02/03 - 03.45',
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
                                  'Cash',
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
                                  'Colombo',
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
                                  'Special note :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  'Special note here',
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
                                  'Total Amount :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  '\$120',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Order Tracking no :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(width: 10,),
                                Flexible(
                                    child: CustomFormField(
                                  controller: _priceController,
                                  height: 35,
                                  hintText: '',
                                )),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       'Order Tracking no :',
                            //       style: TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.w900),
                            //     ),
                            //     Spacer(),
                            //    // CustomFormField(controller: _durationController),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                                text: 'Deliver Order',
                                fontSize: 14,
                                clickCallback: () {}),
                                SizedBox(height: 10,),
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
                            new Image.asset('asserts/images/order_ongoing.png',
                                height: 65, width: 100),
                          ],
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  'Shopping Cart Items',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Spacer(),
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
                                  '2022/02/03 - 03.45',
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
                                  'Cash',
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
                                  'Colombo',
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
                                  'Special note :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  'Special note here',
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
                                  'Total Amount :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  '\$120',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Order Tracking no :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  'EN5869523547856',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            
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
                                width: 65),
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
                                  'Shopping Cart Items',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Spacer(),
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
                                  '2022/02/03 - 03.45',
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
                                  'Cash',
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
                                  'Colombo',
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
                                  'Special note :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  'Special note here',
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
                                  'Total Amount :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  '\$120',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Order Tracking no :',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Spacer(),
                                Text(
                                  'EN5869523547856',
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
                              'Order Review',
                              style: TextStyle(fontWeight: FontWeight.w900),
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
                              style: TextStyle(fontWeight: FontWeight.w900),
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
}
