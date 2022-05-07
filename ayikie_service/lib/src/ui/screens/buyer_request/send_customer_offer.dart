import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendCustomerOffer extends StatefulWidget {
  const SendCustomerOffer({Key? key}) : super(key: key);

  @override
  _SendCustomerOfferState createState() => _SendCustomerOfferState();
}

class _SendCustomerOfferState extends State<SendCustomerOffer> {
  TextEditingController _messageController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

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
            'Send Customer Offer',
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
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Tine Killer',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Description',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  height: 150,
                  child: TextField(
                    maxLines: 9,
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: "Enter a description",
                        fillColor: AppColors.textFieldBackground,
                        filled: true,
                        hintStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
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
                Row(
                  children: [
                    Text(
                      'Order Price',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                    Spacer(),
                    Flexible(
                        child: CustomFormField(
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                    Spacer(),
                    Flexible(
                        child: CustomFormField(
                      controller: _durationController,
                      height: 35,
                      hintText: '1 day',
                    )),
                  ],
                ),
                SizedBox(height: 20,),
                PrimaryButton(text: 'Send Offer', clickCallback: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
