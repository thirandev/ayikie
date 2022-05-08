import 'dart:io';

import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CreditCardVerification extends StatefulWidget {
  const CreditCardVerification({Key? key}) : super(key: key);

  @override
  _CreditCardVerificationState createState() => _CreditCardVerificationState();
}

class _CreditCardVerificationState extends State<CreditCardVerification> {

  TextEditingController _emailController = TextEditingController();


    bool _enterEmail = true;
    bool _enterOtp = false;
    String publicKeyTest = 'pk_test_6e9d10c9cae9aadd7735a89c91ee6c0c01103ecb';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKeyTest);
    super.initState();
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  chargeCard() async {
    var charge = Charge()
    
      ..amount = 10 *
          100 //the money should be in kobo hence the need to multiply the value by 100
      ..reference = _getReference()
      
      ..putCustomField('custom_id',
          '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..currency = 'GHS'    
      
      ..email = 'Ayikie2.0@gmail.com';
      
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    print(response);
    if (response.status == true) {
      _showMessage('Payment was successful!!!');
    } else {
      _showMessage('Payment Failed!!!');
    }
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
          'Credit Card Verification',
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
      body:  SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add your credit card',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.center,
                      child: Text(
                        'No credit card',
                        style: TextStyle(
                            fontSize: 14, ),
                      ),
                    ),
                    
                    SizedBox(height: 30,),
                     PrimaryButton(
                        text: 'Add Card',
                        fontSize: 16,
                        clickCallback: ()=>chargeCard()),
                  ],
                ),
              ),
              
            ),
          ),
        
    );
  }
}
